import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/habit_related/custom_habits_calendar.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/custom_workouts_calendar.dart';

void main() {

  testWidgets('Habit Calendar test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HabitTask habitTaskTrue = HabitTask('This is the task', true);
      final HabitTask habitTaskFalse = HabitTask('This is the task', false);

      final String day1 = DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch.toString();
      final String day2 = DateTime.now().subtract(const Duration(days: 2)).millisecondsSinceEpoch.toString();
      final String day3 = DateTime.now().subtract(const Duration(days: 3)).millisecondsSinceEpoch.toString();

      final Habit habit = Habit(1, day1, 'This is a note', 'A', 'A', false, [habitTaskTrue, habitTaskTrue]);
      final Habit habit2 = Habit(1, day2, 'This is a note', 'A', 'A', false, [habitTaskTrue, habitTaskFalse]);
      final Habit habit3 = Habit(1, day3, 'This is a note', 'A', 'A', false, [habitTaskFalse, habitTaskFalse]);

      final widget = CustomHabitsCalendar(habits: [habit, habit2, habit3]);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Workout Calendar test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests

      final String day1 = DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch.toString();
      final String day2 = DateTime.now().subtract(const Duration(days: 2)).millisecondsSinceEpoch.toString();
      final String day3 = DateTime.now().subtract(const Duration(days: 3)).millisecondsSinceEpoch.toString();

      final widget = CustomWorkoutCalendar(workoutDates: [day1, day2, day3],);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();
    });
  });
}
