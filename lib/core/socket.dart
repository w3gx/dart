part of 'core.dart';

class W3GSocket<T> {
  late String uri;

  WebSocketChannel? _channel;
  T? response;

  W3GSocket({required this.uri});

  Uri get _uri {
    return Uri.parse(uri);
  }

  WebSocketChannel get channel {
    if (_channel == null) {
      _channel = WebSocketChannel.connect(_uri);
      _channel?.stream.listen((message) {
        response = parse(message) as T?;
      });
    }
    return _channel!;
  }

  void send(dynamic data) {
    channel.sink.add(stringify(data));
  }
}
