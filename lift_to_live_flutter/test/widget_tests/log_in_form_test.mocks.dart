// Mocks generated by Mockito 5.3.2 from annotations
// in lift_to_live_flutter/test/widget_tests/log_in_form_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart'
    as _i4;
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart' as _i5;
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart'
    as _i3;
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart'
    as _i2;
import 'package:lift_to_live_flutter/presentation/views/log_in_page_view.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAppState_0 extends _i1.SmartFake implements _i2.AppState {
  _FakeAppState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LogInPagePresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogInPagePresenter extends _i1.Mock
    implements _i3.LogInPagePresenter {
  MockLogInPagePresenter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get repositoriesAttached => (super.noSuchMethod(
        Invocation.getter(#repositoriesAttached),
        returnValue: false,
      ) as bool);
  @override
  set repositoriesAttached(dynamic value) => super.noSuchMethod(
        Invocation.setter(
          #repositoriesAttached,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.AppState get appState => (super.noSuchMethod(
        Invocation.getter(#appState),
        returnValue: _FakeAppState_0(
          this,
          Invocation.getter(#appState),
        ),
      ) as _i2.AppState);
  @override
  void attachRepositories(
    _i4.TokenRepository? tokenRepository,
    _i5.UserRepository? userRepository,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #attachRepositories,
          [
            tokenRepository,
            userRepository,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void attach(_i6.LogInPageView? view) => super.noSuchMethod(
        Invocation.method(
          #attach,
          [view],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void detach() => super.noSuchMethod(
        Invocation.method(
          #detach,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<void> logIn() => (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  void setAppState(_i2.AppState? appState) => super.noSuchMethod(
        Invocation.method(
          #setAppState,
          [appState],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool isInitialized() => (super.noSuchMethod(
        Invocation.method(
          #isInitialized,
          [],
        ),
        returnValue: false,
      ) as bool);
}
