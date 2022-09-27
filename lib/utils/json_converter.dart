import 'dart:convert';

/// json object to string
String stringify(dynamic items) {
  if (items is List) {
    return '[${items.map(stringify).join(',')}]';
  } else if (items is Map) {
    return '{${items.keys.map((key) => '${stringify(key)}:${stringify(items[key])}').join(',')}}';
  } else if (items is String) {
    return '"${items.replaceAll('"', '\\"')}"';
  }
  return items.toString();
}

Map<String, dynamic> parse(String jsonString) {
  return json.decode(jsonString);
}
