class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    _reverseMap = map.map(
      (k, v) => MapEntry(v, k),
    );

    return _reverseMap!;
  }
}

// enum helper functions
String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) =>
    values.firstWhere((v) => key == enumToString(v!));

//Provider Events
enum ProviderEvent {
  none,
}

//Provider States
enum ProviderState {
  none,
  loading,
  noInternet,
  success,
  failed,
  noData,
}
//Api Request Type
enum ApiRequestType {
  apiGet,
  apiPost,
  apiPut,
  apiPatch,
  apiDelete,
}
//Build Type
enum BuildType {
  dev,
  prod,
  uat,
}
//Content Type
enum ContentType {
  json,
  formData,
}
//Language
enum Language {
  en,
  es,
  fr,
}

