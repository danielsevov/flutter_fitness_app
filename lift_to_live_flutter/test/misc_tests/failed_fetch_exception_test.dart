import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';

void main() {
  test('FailedFetchException constructor test', () {
    final exception = FailedFetchException('cause');

    expect(exception, isA<FailedFetchException>());
    expect(exception.cause, 'cause');
  });
}
