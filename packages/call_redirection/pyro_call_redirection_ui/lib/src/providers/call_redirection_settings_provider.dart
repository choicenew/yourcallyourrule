import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallRedirectionSettingsState {
  final bool enableRedirection;
  final bool enableConfirmationDialog;
  final bool enableAutoBlockHighRisk;

  const CallRedirectionSettingsState({
    this.enableRedirection = true,
    this.enableConfirmationDialog = true,
    this.enableAutoBlockHighRisk = true,
  });

  CallRedirectionSettingsState copyWith({
    bool? enableRedirection,
    bool? enableConfirmationDialog,
    bool? enableAutoBlockHighRisk,
  }) {
    return CallRedirectionSettingsState(
      enableRedirection: enableRedirection ?? this.enableRedirection,
      enableConfirmationDialog: enableConfirmationDialog ?? this.enableConfirmationDialog,
      enableAutoBlockHighRisk: enableAutoBlockHighRisk ?? this.enableAutoBlockHighRisk,
    );
  }
}

class CallRedirectionSettingsNotifier extends Notifier<CallRedirectionSettingsState> {
  @override
  CallRedirectionSettingsState build() => const CallRedirectionSettingsState();

  void toggleRedirection(bool enabled) {
    state = state.copyWith(enableRedirection: enabled);
  }

  void toggleConfirmationDialog(bool enabled) {
    state = state.copyWith(enableConfirmationDialog: enabled);
  }

  void toggleAutoBlockHighRisk(bool enabled) {
    state = state.copyWith(enableAutoBlockHighRisk: enabled);
  }
}

final callRedirectionSettingsProvider = NotifierProvider<
    CallRedirectionSettingsNotifier, CallRedirectionSettingsState>(
  CallRedirectionSettingsNotifier.new,
);
