import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';

import '../test_data.dart';

void main() {
  test('Role constructor test', () {
    final role = TestData.test_role_1;
    
    expect(role.userId, 'A');
    expect(role.name, 'A');
  });

  group('Role toJson tests', (){
    test('Role toJson compared to self', () {
      final role = TestData.test_role_1;

      expect(role.toJson().toString() == role.toJson().toString(), true);
    });

    test('Role toJson compared to self 2', () {
      final role = TestData.test_role_1;

      expect(role.toJson().toString(), '{userId: A, name: A}');
    });

    test('Role toJson compared to other', () {
      final role = TestData.test_role_1;
      final role2 = TestData.test_role_2;

      expect(role.toJson().toString() == role2.toJson().toString(), false);
    });
  });

  group('Role fromJson tests', (){
    test('Role fromJson compared to self', () {
      final role = TestData.test_role_1;
      final roleJson = role.toJson();

      expect(role == Role.fromJson(roleJson), true);
    });

    test('Role fromJson compared to other Role', () {
      final role = TestData.test_role_1;
      final role2 = TestData.test_role_2;
      final roleJson = role2.toJson();

      expect(role == Role.fromJson(roleJson), false);
    });
  });

  group('Role equals tests', (){
    test('Role equals compared to self', () {
      final role = TestData.test_role_1;

      expect(role == role, true);
    });

    test('Role equals compared to self 2', () {
      final Role role = TestData.test_role_1;
      final role2 = Role('A', 'A');

      expect(role == role2, true);
    });

    test('Role equals compared to other Role', () {
      final role = TestData.test_role_1;
      final role2 = TestData.test_role_2;

      expect(role == role2, false);
    });
  });

  group('Role hashCode tests', (){
    test('Role hashCode compared to self', () {
      final role = TestData.test_role_1;

      expect(role.hashCode == role.hashCode, true);
    });

    test('Role hashCode compared to self 2', () {
      final role = TestData.test_role_1;
      final role2 = Role('A', 'A');

      expect(role.hashCode == role2.hashCode, true);
    });

    test('Role hashCode compared to other Role', () {
      final role = TestData.test_role_1;
      final role2 = TestData.test_user_1;

      expect(role.hashCode == role2.hashCode, false);
    });
  });
}
