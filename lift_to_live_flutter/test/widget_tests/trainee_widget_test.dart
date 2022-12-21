import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/user.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/user_related/trainee_search_holder.dart';
import 'package:lift_to_live_flutter/presentation/views/trainees_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'trainee_widget_test.mocks.dart';

@GenerateMocks([TraineesPageView])
void main() {

  testWidgets('TraineeSearchWidget test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final User user = TestData.testUser1;
      user.profilePicture = TestData.testImage3;

      final TraineesPageView view = MockTraineesPageView();

      final widget = TraineeSearchHolder(user: user, view: view,);

      final imageFinder = find.byType(Image);
      final nameFinder = find.text('Test User');
      final emailFinder = find.text('user@email.com');
      final buttonFinder = find.byIcon(CupertinoIcons.arrow_right_circle_fill);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: widget,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });
  });

  testWidgets('TraineeSearchWidget test constructor without image', (tester) async {
    await tester.runAsync(() async {
      // tests
      final User user = TestData.testUser1;
      user.profilePicture = null;

      final TraineesPageView view = MockTraineesPageView();

      final widget = TraineeSearchHolder(user: user, view: view);

      final imageFinder = find.byType(Image);
      final nameFinder = find.text('Test User');
      final emailFinder = find.text('user@email.com');
      final buttonFinder = find.byIcon(CupertinoIcons.arrow_right_circle_fill);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: widget,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
    });
  });

  testWidgets('TraineeSearchWidget test navigate to profile page', (tester) async {
    await tester.runAsync(() async {
      // tests
      final User user = TestData.testUser1;

      final TraineesPageView view = MockTraineesPageView();

      final widget = TraineeSearchHolder(user: user, view: view);

      final imageFinder = find.byType(Image);
      final nameFinder = find.text('Test User');
      final emailFinder = find.text('user@email.com');
      final buttonFinder = find.byIcon(CupertinoIcons.arrow_right_circle_fill);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: widget,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      verify(view.navigateToProfilePage('user@email.com')).called(1);
    });
  });
}
