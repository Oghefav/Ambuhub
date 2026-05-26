import 'package:country_state_city/country_state_city.dart' as geo;

class StateLoadResult {
  final List<String> names;
  final Map<String, String> codesByName;

  const StateLoadResult({
    required this.names,
    required this.codesByName,
  });
}

/// Loads states/provinces for an ISO-2 country code (e.g. `NG`, `US`).
Future<StateLoadResult> loadStatesForCountry(String countryCode) async {
  final normalized = countryCode.trim().toUpperCase();
  if (normalized.isEmpty) {
    return const StateLoadResult(names: [], codesByName: {});
  }

  try {
    final states = await geo.getStatesOfCountry(normalized);
    if (states.isEmpty) {
      return const StateLoadResult(names: [], codesByName: {});
    }

    final names = states.map((s) => s.name).toList()..sort();
    final codesByName = <String, String>{
      for (final state in states) state.name: state.isoCode,
    };

    return StateLoadResult(names: names, codesByName: codesByName);
  } catch (_) {
    return const StateLoadResult(names: [], codesByName: {});
  }
}
