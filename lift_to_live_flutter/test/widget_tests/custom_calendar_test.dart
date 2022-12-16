import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_calendar.dart';

void main() {

  testWidgets('Calendar test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HabitTask habitTaskTrue = HabitTask('This is the task', true);
      final HabitTask habitTaskFalse = HabitTask('This is the task', false);

      final String today = DateTime.now().millisecondsSinceEpoch.toString();

      final Habit habit = Habit(1, today, 'This is a note', 'A', 'A', false, [habitTaskTrue, habitTaskTrue]);
      final Habit habit2 = Habit(1, today, 'This is a note', 'A', 'A', false, [habitTaskTrue, habitTaskFalse]);
      final Habit habit3 = Habit(1, today, 'This is a note', 'A', 'A', false, [habitTaskFalse, habitTaskFalse]);

      final widget = CustomCalendar(habits: [habit, habit2, habit3]);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });
  });
}
