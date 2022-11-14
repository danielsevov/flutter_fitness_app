/// Entity class for holding details of a single user-created image instance.
class MyImage {
  String userId, // id of the owner user of the image
      type, // type of the image (profile, front, side, back)
      data, // image blob data
      date; // date of the image
  int id; // id of the image instance

  //Simple constructor for creating a MyImage instance
  MyImage(this.userId, this.type, this.id, this.date, this.data);

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyImage && runtimeType == other.runtimeType && id == other.id;

  //Hashcode function
  @override
  int get hashCode => id.hashCode;

  // Function used for transforming a JSON to an MyImage object.
  MyImage.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        type = json['type'],
        id = json['id'],
        date = json['date'],
        data = json['data'];

  // Function used for transforming a MyImage object to JSON map.
  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'type': type,
        'id': id,
        'date': date,
        'data': data,
      };

  // Function used for generating a string representation of a MyImage instance.
  @override
  String toString() {
    return 'MyImage{userId: $userId, type: $type, data: $data, date: $date, id: $id}';
  }
}
