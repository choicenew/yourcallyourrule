import '../../providers/translation_provider.dart';

enum ProviderStatus {
  ready,
  busy,
  cooldown,
}

enum CircuitState {
  closed,
  open,
  halfOpen,
}

/// Managing the lifecycle state of a single TranslationProvider.
/// Tracks cooldowns, failures, and penalties with a 3-State Circuit Breaker.
class ProviderState {
  final TranslationProvider provider;
  final Duration baseCooldown;
  final String name;

  ProviderStatus _status = ProviderStatus.ready;
  CircuitState _circuitState = CircuitState.closed;

  DateTime _lastActiveTime =
      DateTime.now().subtract(const Duration(days: 1)); // Ready initially
  DateTime? _circuitOpenTime;

  int _failCount = 0;
  int _consecutiveFailures = 0;
  Duration _currentCooldown = Duration.zero;
  Duration _circuitCooldown = const Duration(minutes: 5);
  bool _halfOpenProbeActive = false;

  ProviderState({
    required this.name,
    required this.provider,
    this.baseCooldown = const Duration(seconds: 1),
  });

  ProviderStatus get status => _status;
  CircuitState get circuitState => _circuitState;
  int get failCount => _failCount;
  int get consecutiveFailures => _consecutiveFailures;

  /// Check if the provider is effectively ready (status is READY or Cooldown expired)
  bool get isReady {
    if (_status == ProviderStatus.busy) return false;

    // 1. Check Circuit Breaker State
    if (_circuitState == CircuitState.open) {
      final now = DateTime.now();
      if (_circuitOpenTime != null &&
          now.difference(_circuitOpenTime!) >= _circuitCooldown) {
        _circuitState = CircuitState.halfOpen;
        _halfOpenProbeActive = false;
        print('[$name] Circuit Breaker transitioned from OPEN to HALF_OPEN (Probing...)');
      } else {
        return false; // Circuit is OPEN; block all tasks to prevent wasted network requests
      }
    }

    if (_circuitState == CircuitState.halfOpen) {
      if (_halfOpenProbeActive) return false; // Only 1 probe task allowed at a time
    }

    // 2. Check Short-term Cooldown
    if (_status == ProviderStatus.cooldown) {
      final now = DateTime.now();
      if (now.difference(_lastActiveTime) >= _currentCooldown) {
        _status = ProviderStatus.ready;
        return true;
      }
      return false;
    }

    return true;
  }

  /// Mark the provider as BUSY (working on a task).
  void markBusy() {
    _status = ProviderStatus.busy;
    _lastActiveTime = DateTime.now();
    if (_circuitState == CircuitState.halfOpen) {
      _halfOpenProbeActive = true;
    }
  }

  /// Mark the provider as finished with a task.
  /// [success]: Whether the task was successful.
  void markFinished({required bool success}) {
    _lastActiveTime = DateTime.now();
    _status = ProviderStatus.cooldown;

    if (success) {
      _failCount = 0;
      _consecutiveFailures = 0;
      _currentCooldown = baseCooldown;
      _halfOpenProbeActive = false;
      if (_circuitState != CircuitState.closed) {
        print('[$name] Circuit Breaker RESET to CLOSED after successful response.');
        _circuitState = CircuitState.closed;
        _circuitCooldown = const Duration(minutes: 5);
      }
    } else {
      _failCount++;
      _consecutiveFailures++;

      if (_circuitState == CircuitState.halfOpen) {
        // Probe failed! Re-open circuit with exponential penalty
        _halfOpenProbeActive = false;
        _circuitState = CircuitState.open;
        _circuitOpenTime = DateTime.now();
        _circuitCooldown = _circuitCooldown * 2;
        if (_circuitCooldown > const Duration(hours: 1)) {
          _circuitCooldown = const Duration(hours: 1);
        }
        print('[$name] Circuit Probe FAILED! OPEN for ${_circuitCooldown.inMinutes}m (Consecutive failures: $_consecutiveFailures)');
      } else if (_consecutiveFailures >= 3) {
        // 3 consecutive failures -> Trip circuit breaker to OPEN
        _circuitState = CircuitState.open;
        _circuitOpenTime = DateTime.now();
        print('[$name] TRIPPED CIRCUIT BREAKER! Transitioned to OPEN for ${_circuitCooldown.inMinutes}m (Consecutive failures: $_consecutiveFailures)');
      }

      // Exponential Backoff calculation for short-term cooldown
      final multiplier = 1 << (_failCount > 5 ? 5 : _failCount); // 2^failCount
      final seconds = (10 * multiplier).clamp(10, 60);
      _currentCooldown = Duration(seconds: seconds);

      print(
          '[$name] Failed. Cooldown: ${_currentCooldown.inSeconds}s (Failures: $_failCount, CircuitState: $_circuitState)');
    }
  }
}

