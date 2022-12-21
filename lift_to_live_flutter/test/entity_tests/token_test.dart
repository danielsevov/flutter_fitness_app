import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/token.dart';

import '../test_data.dart';

void main() {
  test('Token constructor test', () {
    final token = TestData.testToken1;
    
    expect(token.token, 'A');
  });

  group('Token toJson tests', (){
    test('Token toJson compared to self', () {
      final token = TestData.testToken1;

      expect(token.toJson().toString() == token.toJson().toString(), true);
    });

    test('Token toJson compared to self 2', () {
      final token = TestData.testToken1;

      expect(token.toJson().toString(), '{token: A}');
    });

    test('Token toJson compared to other', () {
      final token = TestData.testToken1;
      final token2 = TestData.testToken2;

      expect(token.toJson().toString() == token2.toJson().toString(), false);
    });
  });

  group('Token fromJson tests', (){
    test('Token fromJson compared to self', () {
      final token = TestData.testToken1;
      final tokenJson = token.toJson();

      expect(token == Token.fromJson(tokenJson), true);
    });

    test('Token fromJson compared to other Token', () {
      final token = TestData.testToken1;
      final token2 = TestData.testToken2;
      final tokenJson = token2.toJson();

      expect(token == Token.fromJson(tokenJson), false);
    });
  });

  group('Token equals tests', (){
    test('Token equals compared to self', () {
      final token = TestData.testToken1;

      expect(token == token, true);
    });

    test('Token equals compared to self 2', () {
      final Token token = TestData.testToken1;
      final token2 = Token('A');

      expect(token == token2, true);
    });

    test('Token equals compared to other Token', () {
      final token = TestData.testToken1;
      final token2 = TestData.testToken2;

      expect(token == token2, false);
    });
  });

  group('Token hashCode tests', (){
    test('Token hashCode compared to self', () {
      final token = TestData.testToken1;

      expect(token.hashCode == token.hashCode, true);
    });

    test('Token hashCode compared to self 2', () {
      final token = TestData.testToken1;
      final token2 = Token('A');

      expect(token.hashCode == token2.hashCode, true);
    });

    test('Token hashCode compared to other Token', () {
      final token = TestData.testToken1;
      final token2 = TestData.testUser1;

      expect(token.hashCode == token2.hashCode, false);
    });
  });
}
