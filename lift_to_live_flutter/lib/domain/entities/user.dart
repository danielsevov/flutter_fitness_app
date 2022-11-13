class User {
  final String id, email, coach_id, nationality, date_of_birth, name, phone_number;

  User(this.id, this.email, this.coach_id, this.nationality, this.date_of_birth, this.name, this.phone_number);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],email = json['email'],coach_id = json['coach_id'],nationality = json['nationality'],date_of_birth = json['date_of_birth'],name = json['name'],phone_number = json['phone_number'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'coach_id': coach_id,
    'nationality': nationality,
    'date_of_birth': date_of_birth,
    'phone_number': phone_number,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          coach_id == other.coach_id &&
          nationality == other.nationality &&
          date_of_birth == other.date_of_birth &&
          name == other.name &&
          phone_number == other.phone_number;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      coach_id.hashCode ^
      nationality.hashCode ^
      date_of_birth.hashCode ^
      name.hashCode ^
      phone_number.hashCode;
}