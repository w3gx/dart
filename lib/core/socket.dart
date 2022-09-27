part of 'core.dart';

class W3GSocket<T> {
  late String uri;

  final Map<String, Function(T)> _listeners = {};

  WebSocketChannel? _channel;

  W3GSocket({required this.uri});

  Uri get _uri {
    return Uri.parse(uri);
  }

  WebSocketChannel get channel {
    if (_channel == null) {
      _channel = WebSocketChannel.connect(
        _uri,
      );
      _channel!.stream.listen((message) {
        T response = parse(message) as T;
        _listeners.forEach((key, callback) {
          _process(key, callback, response);
        });
      });
    }
    return _channel!;
  }

  void send(dynamic data) {
    channel.sink.add(stringify(data));
  }

  void _process(String event, Function(T) listener, T response) {
    listener(response); // default handler
  }

  void on(String event, Function(T) listener) {
    _listeners[event] = listener;
  }
}
