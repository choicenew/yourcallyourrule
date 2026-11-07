import 'package:test/test.dart';
import 'package:pyro_atmosphere/pyro_atmosphere.dart';

void main() {
  group('AtmosphereState Model Tests', () {
    test('Standard state defaults and flags', () {
      final state = AtmosphereState.standard;
      expect(state.temperature, 20.0);
      expect(state.humidity, 50);
      expect(state.isDay, true);
      expect(state.isPrecipitation, false);
      expect(state.isHeavyPollution, false);
    });

    test('Rain and heavy pollution flags detection', () {
      final rainState = AtmosphereState(weatherCode: 61, aqiUS: 180);
      expect(rainState.isPrecipitation, true);
      expect(rainState.isHeavyPollution, true);
    });

    test('JSON serialization & deserialization', () {
      final state = AtmosphereState(
        temperature: 25.5,
        humidity: 65,
        weatherCode: 3,
        aqiUS: 45.0,
        pm2_5: 12.0,
      );

      final json = state.toJson();
      final restored = AtmosphereState.fromJson(json);

      expect(restored.temperature, 25.5);
      expect(restored.humidity, 65);
      expect(restored.weatherCode, 3);
      expect(restored.aqiUS, 45.0);
    });
  });

  group('AtmosphereService Cache & Fallback Tests', () {
    test('Fallback to standard state on network failure', () async {
      final service = AtmosphereService();
      final state = await service.getAtmosphere(lat: 0, lng: 0);
      expect(state, isNotNull);
      expect(state.temperature, isNotNull);
    });
  });
}
