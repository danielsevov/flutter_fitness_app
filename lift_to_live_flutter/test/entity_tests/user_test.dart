import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/user.dart';

import '../mock_data.dart';

void main() {
  test('User constructor test', () {
    final user = MockData.testUser1;
    user.profilePicture = MockData.testImage1;

    expect(user.id, 'user@email.com');
    expect(user.email, 'user@email.com');
    expect(user.coachId, 'coach@email.com');
    expect(user.nationality, 'NL');
    expect(user.dateOfBirth, '23/12/1999');
    expect(user.phoneNumber, '5555555555');
    expect(user.name, 'Test User');
    expect(user.profilePicture, MockData.testImage1);
  });

  group('User toJson tests', (){
    test('User toJson compared to self', () {
      final user = MockData.testUser1;

      expect(user.toJson().toString() == user.toJson().toString(), true);
    });

    test('User toJson compared to self 2', () {
      final user = MockData.testUser1;

      expect(user.toJson().toString() == '{id: user@email.com, name: Test User, email: user@email.com, coach_id: coach@email.com, nationality: NL, date_of_birth: 23/12/1999, phone_number: 5555555555}', true);
    });

    test('User toJson compared to other', () {
      final user = MockData.testUser1;
      final user2 = MockData.testCoach1;

      expect(user.toJson().toString() == user2.toJson().toString(), false);
    });
  });

  group('User fromJson tests', (){
    test('User fromJson compared to self', () {
      final user = MockData.testUser1;
      final userJson = user.toJson();

      expect(user == User.fromJson(userJson), true);
    });

    test('User fromJson compared to other user', () {
      final user = MockData.testUser1;
      final user2 = MockData.testCoach1;
      final userJson = user2.toJson();

      expect(user == User.fromJson(userJson), false);
    });
  });

  group('User equals tests', (){
    test('User equals compared to self', () {
      final user = MockData.testUser1;

      expect(user == user, true);
    });

    test('User equals compared to self 2', () {
      final user = MockData.testUser1;
      final user2 = User('user@email.com', 'user@email.com', 'coach@email.com', 'NL', '23/12/1999', 'Test User', '5555555555');

      expect(user == user2, true);
    });

    test('User equals compared to other user', () {
      final user = MockData.testUser1;
      final user2 = MockData.testCoach1;

      expect(user == user2, false);
    });
  });

  group('User hashCode tests', (){
    test('User hashCode compared to self', () {
      final user = MockData.testUser1;

      expect(user.hashCode == user.hashCode, true);
    });

    test('User hashCode compared to self 2', () {
      final user = MockData.testUser1;
      final user2 = User('user@email.com', 'user@email.com', 'coach@email.com', 'NL', '23/12/1999', 'Test User', '5555555555');

      expect(user.hashCode == user2.hashCode, true);
    });

    test('User hashCode compared to other user', () {
      final user = MockData.testUser1;
      final user2 = MockData.testCoach1;

      expect(user.hashCode == user2.hashCode, false);
    });
  });
}
