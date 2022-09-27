part of 'core.dart';

class W3GMessage {
  Map<String, dynamic>? parsedData;

  W3GMessage({
    required this.parsedData,
  });

  String get sessionId {
    return payload.message.sessionId;
  }

  Map<String, dynamic> get data {
    return payload.data;
  }

  W3GResponse get payload {
    return W3GResponse(parsedData: parsedData);
  }
}

/// Received data from the server
class W3GResponse {
  String? rawData;
  Map<String, dynamic>? parsedData;

  W3GResponse({
    this.rawData,
    this.parsedData,
  });

  String get path {
    return data["path"];
  }

  String get sessionId {
    return data["message"]["payload"]?["sessionId"];
  }

  Map<String, dynamic> get data {
    if (rawData == null) return parsedData!;
    return parse(rawData!);
  }

  W3GMessage get message {
    return W3GMessage(parsedData: data["message"]);
  }
}
