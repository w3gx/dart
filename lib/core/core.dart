import 'package:w3gx_dart/utils/json_converter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

part 'abstracts.dart';
part 'socket.dart';

/// W3Gx singleton
class W3Gx extends W3GSocket<W3GResponse> {
  final Uuid _uuid = const Uuid();

  /// current session id
  late String sessionId;

  W3Gx._({required super.uri});

  static final W3Gx shared = W3Gx._(uri: "wss://w3gx.herokuapp.com");

  /// opens a connection to the server
  Future<void> connect() async {
    send({"path": "connect"});
  }

  Future<void> disconnect() async {
    send({"path": "disconnect"});
  }

  /// allows sending [data] to w3gx servers.
  @override
  void send(dynamic data) {
    if (data is Map<String, dynamic>) {
      super.send(
        _buildWithSessionId(data),
      );
    } else {
      throw Exception("W3Gx::send: data must be a Map");
    }
  }

  @override
  void _process(
      String event, Function(W3GResponse) listener, W3GResponse response) {
    if (response.path == event && response.message.sessionId == sessionId) {
      listener(response);
    }
  }

  Map<String, dynamic> _buildWithSessionId(Map<String, dynamic> data) {
    if (!data.containsKey("message")) {
      data["message"] = {};
    }
    sessionId = (data["message"]["sessionId"] ??= _uuid.v4());

    return data;
  }
}
