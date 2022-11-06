class Role {
  String userId, name;

  Role(this.userId, this.name);

  Role.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
  };
}