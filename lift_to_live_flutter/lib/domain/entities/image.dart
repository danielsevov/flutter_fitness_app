class MyImage {
  String userId, type, data, date;
  int id;


  MyImage(this.userId, this.type, this.id, this.date, this.data);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyImage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  MyImage.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        type = json['type'],
        id = json['id'],
        date = json['date'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'type': type,
    'id': id,
    'date': date,
    'data': data,
  };

  @override
  String toString() {
    return 'MyImage{userId: $userId, type: $type, data: $data, date: $date, id: $id}';
  }
}