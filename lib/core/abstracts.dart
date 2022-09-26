part of 'core.dart';

abstract class W3GMessage {
  late String sessionId;
  late W3GResponse payload;
  late Map<String, dynamic> data;
}

abstract class W3GResponse {
  late String path;
  late W3GMessage message;
}
