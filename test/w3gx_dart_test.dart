import 'package:flutter_test/flutter_test.dart';

import 'package:w3gx_dart/w3gx_dart.dart';

void main() {
  test('connects and receives response', () {
    w3gx.connect((data) {
      expect(data.path, "connect");
    });
  });
}
