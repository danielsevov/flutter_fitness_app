import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_header.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';

void main() {
  group('set task header tests', () {
    testWidgets('Set task header constructor test', (tester) async {
      await tester.runAsync(() async {
        // tests
        const widget = SetTaskHeader(isTemplate: true);

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

        final widget = SetTaskHolder(repsController: repC, kilosController: kiloC, isCompletedController: compC, isEnabled: true, isTemplate: true);

        await tester.pumpWidget(MaterialApp(
            title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        expect(find.text('Kilograms'), findsOneWidget);
        expect(find.text('Repetitions'), findsOneWidget);
        expect(find.text('Completed?'), findsNothing);
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
        await tester.enterText(repsFinder, 'reps');
        await tester.tap(completeFinder);

        expect(kiloC.text, '');
        expect(repC.text, '');
        expect(compC.text, 'true');
      });
    });

  });

}
