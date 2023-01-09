import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/reusable_elements/custom_heading_text_field.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/editable_set_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_header.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/fixed_set_holder.dart';

void main() {
  group('set task header tests', () {
    testWidgets('Set task header constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        const widget = SetTaskHeader(isTemplate: true, key: Key(''),);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(find.text('Kilograms'), findsOneWidget);
        expect(find.text('Repetitions'), findsOneWidget);
        expect(find.text('Completed?'), findsNothing);
      });
    });

    testWidgets('Set task header constructor test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        const widget = SetTaskHeader(isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(find.text('Kilograms'), findsOneWidget);
        expect(find.text('Repetitions'), findsOneWidget);
        expect(find.text('Completed?'), findsOneWidget);
      });
    });
  });

  group('set task holder tests', () {
    testWidgets('Set task holder constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var repC = TextEditingController();
        var kiloC = TextEditingController();
        var compC = TextEditingController();

        final widget = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: false, isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var kiloFinder = find.byType(TextField).first;
        var repsFinder = find.byType(TextField).last;
        var completeFinder = find.byType(Checkbox);

        expect(kiloFinder, findsOneWidget);
        expect(repsFinder, findsOneWidget);
        expect(completeFinder, findsOneWidget);
      });
    });

    testWidgets('Set task holder constructor test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        var repC = TextEditingController();
        var kiloC = TextEditingController();
        var compC = TextEditingController();

        final widget = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var kiloFinder = find.byType(TextField).first;
        var repsFinder = find.byType(TextField).last;
        var completeFinder = find.byType(Checkbox);

        expect(kiloFinder, findsOneWidget);
        expect(repsFinder, findsOneWidget);
        expect(completeFinder, findsNothing);
      });
    });

    testWidgets('Set task holder enter values test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var repC = TextEditingController();
        var kiloC = TextEditingController();
        var compC = TextEditingController();

        final widget = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var kiloFinder = find.byType(TextField).first;
        var repsFinder = find.byType(TextField).last;
        var completeFinder = find.byType(Checkbox);

        await tester.enterText(kiloFinder, '10');
        await tester.enterText(repsFinder, '20');
        await tester.tap(completeFinder);

        expect(kiloC.text, '10');
        expect(repC.text, '20');
        expect(compC.text, 'true');
      });
    });

    testWidgets('Set task holder enter wrong values test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var repC = TextEditingController();
        var kiloC = TextEditingController();
        var compC = TextEditingController();

        final widget = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var kiloFinder = find.byType(TextField).first;
        var repsFinder = find.byType(TextField).last;
        var completeFinder = find.byType(Checkbox);

        await tester.enterText(kiloFinder, 'kilos');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.enterText(repsFinder, 'reps');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.tap(completeFinder);

        expect(kiloC.text, '');
        expect(repC.text, '');
        expect(compC.text, 'true');
      });
    });
  });

  group('fixed set holder tests', () {
    testWidgets('Fixed set holder constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        var exercise = SingleValueDropDownController();
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        final widget = FixedSetHolder(setTasks: const [], exerciseController: exercise, noteController: note, exercises: exercises, setIndex: 1, isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var setLabel = find.text('Set #1');
        var exField = find.text('Enter exercise');
        var noteField = find.text('Enter note');

        expect(setLabel, findsOneWidget);
        expect(exField, findsOneWidget);
        expect(noteField, findsNothing);
      });
    });

    testWidgets('Fixed set holder constructor test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        final widget = FixedSetHolder(setTasks: const [], exerciseController: exercise, noteController: note, exercises: exercises, setIndex: 1, isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var setLabel = find.text('Set #1');
        var exField = find.text('Ex A');
        var noteField = find.text('This is text');

        expect(setLabel, findsOneWidget);
        expect(exField, findsOneWidget);
        expect(noteField, findsOneWidget);
      });
    });

    testWidgets('Fixed set holder constructor test 3', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        final widget = FixedSetHolder(setTasks: const [], exerciseController: exercise, noteController: note, exercises: exercises, setIndex: 1, isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var lbl1 = find.text('Kilograms');
        var lbl2 = find.text('Repetitions');
        var lbl3 = find.text('Completed?');

        expect(lbl1, findsOneWidget);
        expect(lbl2, findsOneWidget);
        expect(lbl3, findsNothing);
      });
    });

    testWidgets('Fixed set holder constructor test 3', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        final widget = FixedSetHolder(setTasks: const [], exerciseController: exercise, noteController: note, exercises: exercises, setIndex: 1, isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var lbl1 = find.text('Kilograms');
        var lbl2 = find.text('Repetitions');
        var lbl3 = find.text('Completed?');

        expect(lbl1, findsOneWidget);
        expect(lbl2, findsOneWidget);
        expect(lbl3, findsOneWidget);
      });
    });
  });

  group('Heading text field tests', () {
    testWidgets('Headline text field test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var controller = TextEditingController();
        final widget = CustomHeadingTextField(screenHeight: 400, screenWidth: 400, controller: controller, textInputType: TextInputType.multiline, hint: 'Enter something', icon: Icons.calendar_month, color: Helper.yellowColor, isHeadline: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var label = find.text('Enter something');

        expect(label, findsOneWidget);
      });
    });

    testWidgets('Headline text field test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        var controller = TextEditingController();
        final widget = CustomHeadingTextField(screenHeight: 400, screenWidth: 400, controller: controller, textInputType: TextInputType.multiline, hint: 'Enter something', icon: Icons.calendar_month, color: Helper.yellowColor, isHeadline: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var label = find.text('Enter something');

        expect(label, findsOneWidget);
      });
    });
  });

  group('Editable set holder tests', () {
    testWidgets('Editable set holder constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        List<TextEditingController> reps = [], kilos = [], completes = [];

        final widget = EditableSetHolder(setTasks: const [], exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: false);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var lbl1 = find.text('Kilograms');
        var lbl2 = find.text('Repetitions');
        var lbl3 = find.text('Completed?');

        var exField = find.text('Ex A');
        var noteField = find.text('This is text');

        expect(lbl1, findsOneWidget);
        expect(lbl2, findsOneWidget);
        expect(lbl3, findsOneWidget);

        expect(exField, findsOneWidget);
        expect(noteField, findsOneWidget);
      });
    });

    testWidgets('Editable set holder constructor test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        List<TextEditingController> reps = [], kilos = [], completes = [];

        final widget = EditableSetHolder(setTasks: const [], exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        var lbl1 = find.text('Kilograms');
        var lbl2 = find.text('Repetitions');
        var lbl3 = find.text('Completed?');

        var exField = find.text('Ex A');
        var noteField = find.text('This is text');

        expect(lbl1, findsOneWidget);
        expect(lbl2, findsOneWidget);
        expect(lbl3, findsNothing);

        expect(exField, findsOneWidget);
        expect(noteField, findsOneWidget);
      });
    });

    testWidgets('Editable set holder change exercise test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        List<TextEditingController> reps = [], kilos = [], completes = [];
        var tasks = <SetTaskHolder>[];

        final widget = EditableSetHolder(setTasks: tasks, exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        var exField = find.text('Ex A');
        var newExField = find.text('Ex C');

        await tester.tap(exField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        await tester.tap(newExField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        expect(exercise.dropDownValue?.name, 'Ex C');
      });
    });

    testWidgets('Editable set holder add set task test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        List<TextEditingController> reps = [], kilos = [], completes = [];
        var tasks = <SetTaskHolder>[];

        final widget = EditableSetHolder(setTasks: tasks, exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        var buttonFinder = find.text('Add Set');

        await tester.tap(buttonFinder);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        await tester.tap(buttonFinder);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        await tester.tap(buttonFinder);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        expect(tasks.length, 3);
      });
    });

    testWidgets('Editable set holder to workoutSet test', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        var repC = TextEditingController();
        repC.text = '10';
        var kiloC = TextEditingController();
        kiloC.text = '10';
        var compC = TextEditingController();

        List<TextEditingController> reps = [repC], kilos = [kiloC], completes = [compC];

        final task = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        var tasks = <SetTaskHolder>[task];

        final widget = EditableSetHolder(setTasks: tasks, exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        var exField = find.text('Ex A');
        var newExField = find.text('Ex C');

        await tester.tap(exField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        await tester.tap(newExField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        expect(exercise.dropDownValue?.name, 'Ex C');

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        expect(tasks.length, 1);
        expect(widget.toWorkoutSet().toJson().toString(), '{set_note: This is text, reps: [10], kilos: [10], exercise: Ex C, is_completed: true}');
        expect(widget.toWorkoutSet().exercise, 'Ex C');
        expect(widget.toWorkoutSet().setNote, 'This is text');
      });
    });

    testWidgets('Editable set holder to workoutSet test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        var repC = TextEditingController();
        //repC.text = '10';
        var kiloC = TextEditingController();
        //kiloC.text = '10';
        var compC = TextEditingController();

        List<TextEditingController> reps = [repC], kilos = [kiloC], completes = [compC];

        final task = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        var tasks = <SetTaskHolder>[task];

        final widget = EditableSetHolder(setTasks: tasks, exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        expect(tasks.length, 1);
        expect(widget.toWorkoutSet().exercise, '');
        expect(widget.toWorkoutSet().setNote, '');
      });
    });

    testWidgets('Editable set holder to workoutSet test 3', (tester) async {
      await tester.runAsync(() async {
        // tests
        var note = TextEditingController();
        note.text = 'This is text';

        var exercise = SingleValueDropDownController();
        //exercise.dropDownValue = const DropDownValueModel(name: 'Ex A', value: 'Ex A');
        List<String> exercises = ['Ex A', 'Ex B', 'Ex C'];

        var repC = TextEditingController();
        repC.text = '10';
        var kiloC = TextEditingController();
        kiloC.text = '10';
        var compC = TextEditingController();

        List<TextEditingController> reps = [repC], kilos = [kiloC], completes = [compC];

        final task = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        var tasks = <SetTaskHolder>[task];

        final widget = EditableSetHolder(setTasks: tasks, exerciseController: exercise, noteController: note, exercises: exercises, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 2));

        expect(tasks.length, 1);
        expect(widget.toWorkoutSet().exercise, '');
        expect(widget.toWorkoutSet().setNote, '');
      });
    });
  });
}
