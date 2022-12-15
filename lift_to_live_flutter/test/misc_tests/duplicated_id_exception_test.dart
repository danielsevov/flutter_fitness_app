import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/duplicated_id_exception.dart';

void main() {
  test('DuplicatedIdException constructor test', () {
    final exception = DuplicatedIdException('cause');

    expect(exception, isA<DuplicatedIdException>());
    expect(exception.cause, 'cause');
  });
}
