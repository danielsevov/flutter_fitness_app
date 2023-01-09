import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/habit_related/edit_habit_holder.dart';

void main() {

  testWidgets('EditHabitHolderWidget test constructor ', (tester) async {
    await tester.runAsync(() async {
      // tests
      var newController = TextEditingController();
      var bodyElements = <Widget>[];
      var controllers = [newController];
      callback(){}

      final widget = EditHabitHolder(newController: newController, bodyElements: bodyElements, screenWidth: 300, controllers: controllers, callback: callback);

      bodyElements.add(widget);

      final noteFinder = find.text('Enter new habit');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();

      expect(noteFinder, findsOneWidget);
    });
  });

  testWidgets('EditHabitHolderWidget test constructor ', (tester) async {
    await tester.runAsync(() async {
      // tests
      var newController = TextEditingController();
      var bodyElements = <Widget>[];
      var controllers = [newController];
      callback(){}

      final widget = EditHabitHolder(newController: newController, bodyElements: bodyElements, screenWidth: 300, controllers: controllers, callback: callback);

      bodyElements.add(widget);

      final iconFinder = find.byIcon(Icons.cancel);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();

      expect(bodyElements.length, 1);
      expect(controllers.length, 1);

      await tester.tap(iconFinder);

      expect(bodyElements.length, 0);
      expect(controllers.length, 0);
    });
  });
}
