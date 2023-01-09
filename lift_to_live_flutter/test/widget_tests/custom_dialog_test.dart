import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/reusable_elements/custom_dialog.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
void main() {

  testWidgets('CustomDialog test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      var dialog = CustomDialog(title: 'Sign out', bodyText: 'Are you sure you want to sign out?', confirm: (){}, cancel: (){});

      final titleFinder = find.text('Sign out');
      final messageFinder = find.text('Are you sure you want to sign out?');
      final iconFinder = find.byIcon(Icons.check_circle);
      final icon2Finder = find.byIcon(Icons.cancel);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: dialog)));

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
      expect(icon2Finder, findsOneWidget);
    });
  });

  testWidgets('LogOutDialog cancel test', (tester) async {
    await tester.runAsync(() async {
      bool confirmed = false, canceled = false;
      var dialog = CustomDialog(title: 'Sign out', bodyText: 'Are you sure you want to sign out?', confirm: (){confirmed = true;}, cancel: (){canceled = true;});

      final icon2Finder = find.byIcon(Icons.cancel);

      await tester.pumpWidget(MaterialApp(
      title: 'Flutter Demo', home: Scaffold(body: dialog)));

      await tester.pump(const Duration(seconds: 0));

      await tester.tap(icon2Finder);

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();

      expect(confirmed, false);
      expect(canceled, true);
    });
  });

  testWidgets('LogOutDialog accept test', (tester) async {
    await tester.runAsync(() async {
      // tests
      bool confirmed = false, canceled = false;
      var dialog = CustomDialog(title: 'Sign out', bodyText: 'Are you sure you want to sign out?', confirm: (){confirmed = true;}, cancel: (){canceled = true;});

      final iconFinder = find.byIcon(Icons.check_circle);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: dialog)));

      await tester.pump(const Duration(seconds: 0));

      await tester.tap(iconFinder);

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();

      expect(canceled, false);
      expect(confirmed, true);
    });
  });
}
