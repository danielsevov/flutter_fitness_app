import 'package:lift_to_live_flutter/domain/entities/image.dart';

/// Entity class for holding the details of a single user instance.
class User {
  final String id, // id of the user
      email, // email of the user
      coachId, // id of the coach of the user
      nationality, // nationality of the user
      dateOfBirth, // date of birth of the user
      name, // name of the user
      phoneNumber; // phone number of the user

  MyImage? profilePicture;

  // Simple constructor for creating an instance of an Habit entry
  User(this.id, this.email, this.coachId, this.nationality, this.dateOfBirth,
      this.name, this.phoneNumber);

  // Function used for transforming a JSON to an User object.
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        coachId = json['coach_id'],
        nationality = json['nationality'],
        dateOfBirth = json['date_of_birth'],
        name = json['name'],
        phoneNumber = json['phone_number'];

  // Function used for transforming a User object to JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'coach_id': coachId,
        'nationality': nationality,
        'date_of_birth': dateOfBirth,
        'phone_number': phoneNumber,
      };

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          coachId == other.coachId &&
          nationality == other.nationality &&
          dateOfBirth == other.dateOfBirth &&
          name == other.name &&
          phoneNumber == other.phoneNumber;

  //Hashcode function
  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      coachId.hashCode ^
      nationality.hashCode ^
      dateOfBirth.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode;
}
