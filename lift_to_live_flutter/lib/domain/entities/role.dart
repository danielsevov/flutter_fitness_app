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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Role &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name;

  @override
  int get hashCode => userId.hashCode ^ name.hashCode;
}