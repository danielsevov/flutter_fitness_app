/// Entity class for holding details of a single user role instance.
class Role {
  String userId, // id of the user owner of the role
      name; // role name (coach, admin)

  //Simple constructor for creating a role instance
  Role(this.userId, this.name);

  // Function used for transforming a JSON to an Role object.
  Role.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'];

  // Function used for transforming a Role object to JSON map.
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
      };

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Role &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name;

  //Hashcode function
  @override
  int get hashCode => userId.hashCode ^ name.hashCode;
}
