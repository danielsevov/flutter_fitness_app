/// Entity class for holding details of a single exercise.
class Exercise {
  String bodyPart, // The targeted body part
  equipment, // The used equipment
  gifUrl, // the url of the tutorial gif
  name, // name of the exercise
  muscleGroup; // the targeted muscle group

  // Simple constructor for creating a workout set instance
  Exercise(this.bodyPart, this.equipment, this.gifUrl, this.name, this.muscleGroup);

  // Function used for transforming a JSON to a workout set object.
  Exercise.fromJson(Map<String, dynamic> json)
      : bodyPart = json['bodyPart'],
        equipment = json['equipment'],
        gifUrl = json['gifUrl'],
        name = json['name'],
        muscleGroup = json['target'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          bodyPart == other.bodyPart &&
          equipment == other.equipment &&
          gifUrl == other.gifUrl &&
          name == other.name &&
          muscleGroup == other.muscleGroup;

  @override
  int get hashCode =>
      bodyPart.hashCode ^
      equipment.hashCode ^
      gifUrl.hashCode ^
      name.hashCode ^
      muscleGroup.hashCode;
}
