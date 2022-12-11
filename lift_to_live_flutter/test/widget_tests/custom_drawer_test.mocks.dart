// Mocks generated by Mockito 5.3.2 from annotations
// in lift_to_live_flutter/test/widget_tests/custom_drawer_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:lift_to_live_flutter/domain/entities/news.dart' as _i5;
import 'package:lift_to_live_flutter/domain/entities/user.dart' as _i3;
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart'
    as _i2;
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

/// A class which mocks [HomePageView].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomePageView extends _i1.Mock implements _i2.HomePageView {
  MockHomePageView() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void setUserData(
    _i3.User? user,
    _i4.Image? profilePicture,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setUserData,
          [
            user,
            profilePicture,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setNewsData(_i5.News? currentNews) => super.noSuchMethod(
        Invocation.method(
          #setNewsData,
          [currentNews],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setInProgress(bool? inProgress) => super.noSuchMethod(
        Invocation.method(
          #setInProgress,
          [inProgress],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setFetched(bool? fetched) => super.noSuchMethod(
        Invocation.method(
          #setFetched,
          [fetched],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyWrongURL(String? s) => super.noSuchMethod(
        Invocation.method(
          #notifyWrongURL,
          [s],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void habitsPressed(
    _i4.BuildContext? context,
    bool? bottomBarButton,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #habitsPressed,
          [
            context,
            bottomBarButton,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void profilePressed(
    _i4.BuildContext? context,
    bool? bottomBarButton,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #profilePressed,
          [
            context,
            bottomBarButton,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void logOutPressed(_i4.BuildContext? context) => super.noSuchMethod(
        Invocation.method(
          #logOutPressed,
          [context],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void traineesPressed(
    _i4.BuildContext? context,
    bool? bottomBarButton,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #traineesPressed,
          [
            context,
            bottomBarButton,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void redirectToUrl(int? index) => super.noSuchMethod(
        Invocation.method(
          #redirectToUrl,
          [index],
        ),
        returnValueForMissingStub: null,
      );
}
