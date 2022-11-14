import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';

void main() {
  test('FetchFailedException constructor test', () {
    final exception = FetchFailedException('cause');

    expect(exception, isA<FetchFailedException>());
    expect(exception.cause, 'cause');
  });

}
