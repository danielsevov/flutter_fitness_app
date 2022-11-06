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
}