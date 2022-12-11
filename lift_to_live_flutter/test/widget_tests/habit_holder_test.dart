import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/habit_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/habit_task_holder.dart';
import 'habit_task_holder_test.mocks.dart';

void main() {

  testWidgets('HabitHolderWidget test constructor thumb up', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HabitsPagePresenter presenter = MockHabitsPagePresenter();
      final HabitTask habitTask = HabitTask('This is the task', true);
      final Habit habit = Habit(1, '946681200000', 'This is a note', 'A', 'A', false, [habitTask]);
      final habitTaskWidget = HabitTaskHolder(habit: habit, habitTask: habitTask, presenter: presenter);
      final widget = HabitHolder(habit: habit, habitTaskWidgets: [habitTaskWidget]);

      final checkBoxFinder = find.byType(HabitTaskHolder);
      final noteFinder = find.text('Coach note: This is a note');
      final iconFinder = find.byIcon(Icons.thumb_up);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(checkBoxFinder, findsOneWidget);
      expect(noteFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });
  });

  testWidgets('HabitHolderWidget test constructor thumb down', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HabitsPagePresenter presenter = MockHabitsPagePresenter();
      final HabitTask habitTask = HabitTask('This is the task', false);
      final Habit habit = Habit(1, '946681200000', 'This is a note', 'A', 'A', false, [habitTask]);
      final habitTaskWidget = HabitTaskHolder(habit: habit, habitTask: habitTask, presenter: presenter);
      final widget = HabitHolder(habit: habit, habitTaskWidgets: [habitTaskWidget]);

      final iconFinder = find.byIcon(Icons.thumb_down);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(iconFinder, findsOneWidget);
    });
  });

  testWidgets('HabitHolderWidget test constructor thumb up and down', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HabitsPagePresenter presenter = MockHabitsPagePresenter();
      final HabitTask habitTask = HabitTask('This is the task', false), habitTask2 = HabitTask('This is the task', true);
      final Habit habit = Habit(1, '946681200000', 'This is a note', 'A', 'A', false, [habitTask, habitTask2]);
      final habitTaskWidget = HabitTaskHolder(habit: habit, habitTask: habitTask, presenter: presenter);
      final habitTaskWidget2 = HabitTaskHolder(habit: habit, habitTask: habitTask2, presenter: presenter);
      final widget = HabitHolder(habit: habit, habitTaskWidgets: [habitTaskWidget, habitTaskWidget2]);

      final iconFinder = find.byIcon(Icons.thumbs_up_down);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(iconFinder, findsOneWidget);
    });
  });
}
