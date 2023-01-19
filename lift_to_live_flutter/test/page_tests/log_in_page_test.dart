import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/factory/abstract_page_factory.dart';
import 'package:lift_to_live_flutter/factory/abstract_presenter_factory.dart';
import 'package:lift_to_live_flutter/factory/page_factory.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:provider/provider.dart';

import '../mock_presenter_factory.dart';

AbstractPresenterFactory presenterFactory = MockPresenterFactory();
AbstractPageFactory pageFactory = PageFactory();

void main() {
  pageFactory.setPresenterFactory(presenterFactory);

  testWidgets('A test', (tester) async {
    final widget = pageFactory.getLogInPage();

    await tester.pumpWidget(Provider<AppState>(
        create: (_) => AppState(),
        child: SizedBox(
          height: 200,
          width: 200,
          child: MaterialApp(
            //set the title of the app
              title: 'TestLiftToLiveApp',

              //set the primary color of the app
              theme: ThemeData(
                  backgroundColor: Helper.pageBackgroundColor,
                  canvasColor: Helper.blueColor),

              // set the entry page to be log in page
              home: widget),
        )));

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Sign In'), findsOneWidget);
  });
}
