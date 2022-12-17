import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/presentation/presenters/picture_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/image_related/detail_screen.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/image_related/my_image_holder.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_holder_test.mocks.dart';

@GenerateMocks([PicturePagePresenter])
void main() {

  testWidgets('DetailedScreen test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final img = Image.asset('assets/images/prof_pic.png');

      final screen = DetailScreen(img: img);

      final imageFinder = find.image(img.image);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
    });
  });

  testWidgets('DetailedScreen test tap', (tester) async {
    await tester.runAsync(() async {
      // tests
      final img = Image.asset('assets/images/prof_pic.png');

      final screen = DetailScreen(img: img);

      final imageFinder = find.image(img.image);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);

      await tester.tap(imageFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsNothing);
    });
  });

  testWidgets('Image holder test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockPicturePagePresenter();

      final img = Image.asset('assets/images/prof_pic.png');
      String date = '1669722779000';
      int id = 12;


      final screen = MyImageHolder(img: img, date: date, id: id, presenter: presenter);

      final imageFinder = find.image(img.image);
      final dateFinder = find.text('29/11/2022');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);

      await tester.tap(imageFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsWidgets);
    });
  });

  testWidgets('Image holder test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockPicturePagePresenter();

      final img = Image.asset('assets/images/prof_pic.png');
      String date = '1669722779000';
      int id = 12;


      final screen = MyImageHolder(img: img, date: date, id: id, presenter: presenter);

      final imageFinder = find.image(img.image);
      final dateFinder = find.text('29/11/2022');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);
    });
  });

  testWidgets('Image holder initiate delete test', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockPicturePagePresenter();

      final img = Image.asset('assets/images/prof_pic.png');
      String date = '1669722779000';
      int id = 12;


      final screen = MyImageHolder(img: img, date: date, id: id, presenter: presenter);

      final imageFinder = find.image(img.image);
      final deleteIconFinder = find.byIcon(Icons.cancel_rounded);
      final cancelFinder = find.byIcon(Icons.cancel);
      final agreeFinder = find.byIcon(Icons.check_circle);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(deleteIconFinder, findsOneWidget);

      await tester.tap(deleteIconFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(cancelFinder, findsOneWidget);
      expect(agreeFinder, findsOneWidget);
    });
  });

  testWidgets('Image holder cancel test', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockPicturePagePresenter();

      final img = Image.asset('assets/images/prof_pic.png');
      String date = '1669722779000';
      int id = 12;


      final screen = MyImageHolder(img: img, date: date, id: id, presenter: presenter);

      final imageFinder = find.image(img.image);
      final deleteIconFinder = find.byIcon(Icons.cancel_rounded);
      final cancelFinder = find.byIcon(Icons.cancel);
      final agreeFinder = find.byIcon(Icons.check_circle);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(deleteIconFinder, findsOneWidget);

      await tester.tap(deleteIconFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(cancelFinder, findsOneWidget);
      expect(agreeFinder, findsOneWidget);

      await tester.tap(cancelFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(cancelFinder, findsNothing);
      expect(imageFinder, findsOneWidget);
    });
  });

  testWidgets('Image holder cancel test', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockPicturePagePresenter();
      when(presenter.deleteImage(any)).thenAnswer((realInvocation) async => {});

      final img = Image.asset('assets/images/prof_pic.png');
      String date = '1669722779000';
      int id = 12;


      final screen = MyImageHolder(img: img, date: date, id: id, presenter: presenter);

      final imageFinder = find.image(img.image);
      final deleteIconFinder = find.byIcon(Icons.cancel_rounded);
      final cancelFinder = find.byIcon(Icons.cancel);
      final agreeFinder = find.byIcon(Icons.check_circle);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: screen,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(imageFinder, findsOneWidget);
      expect(deleteIconFinder, findsOneWidget);

      await tester.tap(deleteIconFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(cancelFinder, findsOneWidget);
      expect(agreeFinder, findsOneWidget);

      await tester.tap(agreeFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(cancelFinder, findsNothing);
      expect(agreeFinder, findsNothing);
      verify(presenter.deleteImage(12)).called(1);
    });
  });
}
