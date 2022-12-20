import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/repositories/exercise_repo_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('test get exercises', () async {
    final repo = ExerciseRepoImpl();
    var list = await repo.getExercises();

    expect(list.length, 1327);
    expect(list.first.name, 'band single leg reverse calf raise');
    expect(list.first.equipment, 'band');
    expect(list.first.bodyPart, 'lower legs');
    expect(list.first.muscleGroup, 'calves');
  });
}
