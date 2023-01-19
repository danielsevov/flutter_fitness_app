import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/news_related/news_article_holder.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import 'article_holder_test.mocks.dart';

@GenerateMocks([HomePageView])
void main() {

  testWidgets('ArticleHolderWidget test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HomePageView view = MockHomePageView();
      when(view.currentNews).thenReturn(MockData.testNews3);

      final widget = NewsArticleHolder(view: view, index: 0);

      final buttonFinder = find.byIcon(CupertinoIcons.arrow_turn_down_right);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();

      expect(buttonFinder, findsOneWidget);
    });
  });

  testWidgets('ArticleHolderWidget test redirect', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HomePageView view = MockHomePageView();
      when(view.currentNews).thenReturn(MockData.testNews3);

      final widget = NewsArticleHolder(view: view, index: 0);

      final buttonFinder = find.byIcon(CupertinoIcons.arrow_turn_down_right);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 0));
      await tester.pumpAndSettle();
      await tester.tap(buttonFinder);

      verify(view.redirectToUrl(0)).called(1);
    });
  });
}
