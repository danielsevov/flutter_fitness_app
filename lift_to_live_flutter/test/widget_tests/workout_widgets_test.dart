import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/reusable_elements/custom_heading_text_field.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/editable_set_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_header.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/fixed_set_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/template_workout_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/workout_holder.dart';

import '../mock_data.dart';

void main() {
  group('set task header tests', () {
    testWidgets('Set task header constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        const widget = SetTaskHeader(isTemplate: true, key: Key(''),);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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

        await tester.pump(const Duration(seconds: 0));
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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];

        List<TextEditingController> reps = [], kilos = [], completes = [];

        final widget = EditableSetHolder(exercises: exercises,setTasks: const [], exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: false,);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 0));
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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];


        List<TextEditingController> reps = [], kilos = [], completes = [];

        final widget = EditableSetHolder(exercises: exercises,setTasks: const [], exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 0));
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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];


        List<TextEditingController> reps = [], kilos = [], completes = [];

        final widget = EditableSetHolder(exercises: exercises,setTasks: const [], exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        var exField = find.text('Ex A');
        var newExField = find.text('Ex C');

        await tester.tap(exField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(newExField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];


        List<TextEditingController> reps = [], kilos = [], completes = [];
        var tasks = <SetTaskHolder>[];

        final widget = EditableSetHolder(exercises: exercises,setTasks: tasks, exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        var buttonFinder = find.text('Add Set');

        await tester.tap(buttonFinder);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(buttonFinder);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(buttonFinder);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];

        var repC = TextEditingController();
        repC.text = '10';
        var kiloC = TextEditingController();
        kiloC.text = '10';
        var compC = TextEditingController();

        List<TextEditingController> reps = [repC], kilos = [kiloC], completes = [compC];

        final task = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        var tasks = <SetTaskHolder>[task];

        final widget = EditableSetHolder(exercises: exercises,setTasks: tasks, exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        var exField = find.text('Ex A');
        var newExField = find.text('Ex C');

        await tester.tap(exField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(newExField);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(exercise.dropDownValue?.name, 'Ex C');

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];

        var repC = TextEditingController();
        //repC.text = '10';
        var kiloC = TextEditingController();
        //kiloC.text = '10';
        var compC = TextEditingController();

        List<TextEditingController> reps = [repC], kilos = [kiloC], completes = [compC];

        final task = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        var tasks = <SetTaskHolder>[task];

        final widget = EditableSetHolder(exercises: exercises,setTasks: tasks, exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

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
        List<String> exerciseNames = ['Ex A', 'Ex B', 'Ex C'];
        List<Exercise> exercises = [MockData.testExercise1, MockData.testExercise2, MockData.testExercise1];

        var repC = TextEditingController();
        repC.text = '10';
        var kiloC = TextEditingController();
        kiloC.text = '10';
        var compC = TextEditingController();

        List<TextEditingController> reps = [repC], kilos = [kiloC], completes = [compC];

        final task = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: false);

        var tasks = <SetTaskHolder>[task];

        final widget = EditableSetHolder(exercises: exercises,setTasks: tasks, exerciseController: exercise, noteController: note, exerciseNames: exerciseNames, repsControllers: reps, kilosControllers: kilos, isCompletedControllers: completes, tag: 'HeroTag', isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(tasks.length, 1);
        expect(widget.toWorkoutSet().exercise, '');
        expect(widget.toWorkoutSet().setNote, '');
      });
    });
  });

  group('workout holder tests', () {
    testWidgets('Workout holder constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        final widget = WorkoutHolder(workoutSetItems: const [], name: 'Workout Name', note: 'my note', created: '1673270770860', completed: '', duration: '600', totalVolume: '3000 kgs', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {},);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(find.text('Workout Name'), findsOneWidget);
        expect(find.text('my note'), findsOneWidget);
        expect(find.text('09/01/2023'), findsOneWidget);
        expect(find.text('not completed'), findsOneWidget);
        expect(find.text('10 minutes'), findsOneWidget);
        expect(find.text('3000 kgs'), findsOneWidget);
        expect(find.text('Show sets'), findsOneWidget);
      });
    });

    testWidgets('Workout holder constructor test 2', (tester) async {
      await tester.runAsync(() async {
        // tests
        final widget = WorkoutHolder(workoutSetItems: const [], name: 'Workout Name', note: '', created: '1673270770860', completed: '1673270770860', duration: '600', totalVolume: '3000 kgs', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {},);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(find.text('Workout Name'), findsOneWidget);
        expect(find.byIcon(Icons.notes), findsNothing);
        expect(find.text('09/01/2023'), findsNWidgets(2));
        expect(find.text('not completed'), findsNothing);
        expect(find.text('10 minutes'), findsOneWidget);
        expect(find.text('3000 kgs'), findsOneWidget);
        expect(find.text('Show sets'), findsOneWidget);
      });
    });

    testWidgets('Workout holder edit workout test', (tester) async {
      await tester.runAsync(() async {
        // tests
        bool edited = false;
        final widget = WorkoutHolder(workoutSetItems: const [], name: 'Workout Name', note: '', created: '1673270770860', completed: '1673270770860', duration: '3600', totalVolume: '3000 kgs', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {edited = true;},);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.edit_note_outlined));

        expect(edited, true);
      });
    });

    testWidgets('Workout holder open/close body expansion test', (tester) async {
      await tester.runAsync(() async {
        // tests
        final widget = WorkoutHolder(workoutSetItems: const [], name: 'Workout Name', note: '', created: '1673270770860', completed: '1673270770860', duration: '3600', totalVolume: '3000 kgs', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {},);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.text('Show sets'));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(find.text('Hide sets'), findsOneWidget);
      });
    });
  });

  group('workout template holder tests', () {
    testWidgets('Workout template holder constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        final widget = TemplateWorkoutHolder(workoutSetItems: const [], name: 'Template Name', note: 'my note', creationDate: '1673270770860', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {}, onSubmit: () { }, onStartWorkout: (BuildContext context) {}, currentUser: 'email@email.com',);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(find.text('Template Name'), findsOneWidget);
        expect(find.text('Note: my note'), findsOneWidget);
        expect(find.text('Created on 09/01/2023'), findsOneWidget);
        expect(find.text('Show sets'), findsOneWidget);
      });
    });

    testWidgets('Workout template holder edit workout template test', (tester) async {
      await tester.runAsync(() async {
        // tests
        bool edited = false;
        final widget = TemplateWorkoutHolder(workoutSetItems: const [], name: 'Template Name', note: 'my note', creationDate: '1673270770860', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {edited = true;}, onSubmit: () { }, onStartWorkout: (BuildContext context) {}, currentUser: 'email@email.com');

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.edit_note_outlined));

        expect(edited, true);
      });
    });

    testWidgets('Workout template holder open/close body expansion test', (tester) async {
      await tester.runAsync(() async {
        // tests
        final widget = TemplateWorkoutHolder(workoutSetItems: const [], name: 'Template Name', note: 'my note', creationDate: '1673270770860', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {}, onSubmit: () { }, onStartWorkout: (BuildContext context) {},currentUser: 'email@email.com');

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.text('Show sets'));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        expect(find.text('Hide sets'), findsOneWidget);
      });
    });

    testWidgets('Workout template holder start workout from template test', (tester) async {
      await tester.runAsync(() async {
        // tests
        bool started = false;
        final widget = TemplateWorkoutHolder(workoutSetItems: const [], name: 'Template Name', note: 'my note', creationDate: '1673270770860', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {}, onSubmit: () { }, onStartWorkout: (BuildContext context) {started = true;},currentUser: 'email@email.com');

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.fitness_center_outlined));

        expect(started, true);
      });
    });

    testWidgets('Workout template holder copy workout template test', (tester) async {
      await tester.runAsync(() async {
        // tests
        bool copied = false;
        final widget = TemplateWorkoutHolder(workoutSetItems: const [], name: 'Template Name', note: 'my note', creationDate: '1673270770860', userId: 'email@email.com', id: 1, onEdit: (BuildContext context) {}, onSubmit: () {copied = true; }, onStartWorkout: (BuildContext context) {},currentUser: 'email@email.com');

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.copy));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.cancel));

        expect(copied, false);

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.copy));

        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 0));

        await tester.tap(find.byIcon(Icons.check_circle));

        expect(copied, true);
      });
    });
  });
}
