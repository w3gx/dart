import 'package:w3gx_dart/utils/json_converter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'abstracts.dart';
part 'socket.dart';

/// W3Gx singleton class
class W3Gx extends W3GSocket<W3GResponse> {
  W3Gx._privateConstructor({required super.uri});

  static final W3Gx shared =
      W3Gx._privateConstructor(uri: "ws://w3gx.herokuapp.com");

  Future<void> connect() async {
    send({"path": "connect"});
  }
}
