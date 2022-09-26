part of 'core.dart';

class W3GSocket<T> {
  late String uri;

  final List<Function(T?)> _listeners = [];

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
        for (var listener in _listeners) {
          _process(listener, response);
        }
      });
    }
    return _channel!;
  }

  void send(dynamic data) {
    channel.sink.add(stringify(data));
  }

  void _process(Function(T?) listener, T? response) {
    listener(response);
  }

  void listen(Function(T?) listener) {
    _listeners.add(listener);
  }
}
