import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/log_in_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../presenter_tests/log_in_page_presenter_test.mocks.dart';


class MockLogInPagePresenter extends LogInPagePresenter {
  MockLogInPagePresenter(super.tokenRepository, super.userRepository);

  @override
  Future<void> logIn() async {

  }
}

@GenerateMocks([TokenRepository, UserRepository])
void main() {

  testWidgets('LogInPage test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter(MockTokenRepository(), MockUserRepository());
      final AppState appState = AppState();
      final page = LogInPage(presenter: presenter,);

      final titleFinder = find.text('Sign In');
      final iconFinder = find.byIcon(Icons.email_outlined);
      final icon2Finder = find.byIcon(Icons.key);

      await tester.pumpWidget(Provider<AppState>(
          create: (_) => appState,
          child: MaterialApp(
          title: 'Flutter Demo', home: page)));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
      expect(icon2Finder, findsOneWidget);
    });
  });
}
