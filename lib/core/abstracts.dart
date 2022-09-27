part of 'core.dart';

abstract class W3GMessage {
  late String sessionId;
  late W3GResponse payload;
  late Map<String, dynamic> data;
}

/// Received data from the server
abstract class W3GResponse {
  late String path;
  late W3GMessage message;
}
