import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/habit_task_holder.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'habit_task_holder_test.mocks.dart';

@GenerateMocks([HabitsPagePresenter])
void main() {

  testWidgets('HabitTaskHolderWidget test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HabitsPagePresenter presenter = MockHabitsPagePresenter();
      final HabitTask habitTask = HabitTask('This is the task', false);
      final Habit habit = Habit(1, '946681200000', 'A', 'A', 'A', false, [habitTask]);

      final widget = HabitTaskHolder(habit: habit, habitTask: habitTask, presenter: presenter);

      final checkBoxFinder = find.byType(Checkbox);
      final taskFinder = find.text('This is the task');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(checkBoxFinder, findsOneWidget);
      expect(taskFinder, findsOneWidget);
    });
  });

  testWidgets('HabitTaskHolderWidget tap test', (tester) async {
    await tester.runAsync(() async {
      // tests
      String dateLater = '32503676400000';
      final HabitsPagePresenter presenter = MockHabitsPagePresenter();
      when(presenter.isOwner()).thenReturn(true);

      final HabitTask habitTask = HabitTask('This is the task', false);
      final Habit habitLate = Habit(1, dateLater, 'A', 'A', 'A', false, [habitTask]);

      final widget = HabitTaskHolder(habit: habitLate, habitTask: habitTask, presenter: presenter);

      final checkBoxFinder = find.byType(Checkbox);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await tester.tap(checkBoxFinder);
      verify(presenter.updateHabitEntry(1, '32503676400000', 'A', 'A', 'A', [HabitTask('This is the task', true)])).called(1);
    });
  });

  testWidgets('HabitTaskHolderWidget tap test', (tester) async {
    await tester.runAsync(() async {
      // tests
      String dateEarlier = '946681200000';
      final HabitsPagePresenter presenter = MockHabitsPagePresenter();
      when(presenter.isOwner()).thenReturn(true);

      final HabitTask habitTask = HabitTask('This is the task', false);
      final Habit habitEarly = Habit(1, dateEarlier, 'A', 'A', 'A', false, [habitTask]);

      final widget = HabitTaskHolder(habit: habitEarly, habitTask: habitTask, presenter: presenter);

      final checkBoxFinder = find.byType(Checkbox);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await tester.tap(checkBoxFinder);
      verifyNever(presenter.updateHabitEntry(1, '946681200000', 'A', 'A', 'A', [HabitTask('This is the task', true)]));
    });
  });
}
