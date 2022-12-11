// Mocks generated by Mockito 5.3.2 from annotations
// in lift_to_live_flutter/test/widget_tests/habit_task_holder_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:lift_to_live_flutter/domain/entities/habit.dart' as _i2;
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart' as _i7;
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart'
    as _i4;
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart'
    as _i3;
import 'package:lift_to_live_flutter/presentation/views/habits_page_view.dart'
    as _i5;
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

class _FakeHabit_0 extends _i1.SmartFake implements _i2.Habit {
  _FakeHabit_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAppState_1 extends _i1.SmartFake implements _i3.AppState {
  _FakeAppState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HabitsPagePresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockHabitsPagePresenter extends _i1.Mock
    implements _i4.HabitsPagePresenter {
  MockHabitsPagePresenter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Habit get template => (super.noSuchMethod(
        Invocation.getter(#template),
        returnValue: _FakeHabit_0(
          this,
          Invocation.getter(#template),
        ),
      ) as _i2.Habit);
  @override
  set template(_i2.Habit? _template) => super.noSuchMethod(
        Invocation.setter(
          #template,
          _template,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i2.Habit> get habits => (super.noSuchMethod(
        Invocation.getter(#habits),
        returnValue: <_i2.Habit>[],
      ) as List<_i2.Habit>);
  @override
  _i3.AppState get appState => (super.noSuchMethod(
        Invocation.getter(#appState),
        returnValue: _FakeAppState_1(
          this,
          Invocation.getter(#appState),
        ),
      ) as _i3.AppState);
  @override
  void attach(_i5.HabitsPageView? view) => super.noSuchMethod(
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
  _i6.Future<void> fetchData() => (super.noSuchMethod(
        Invocation.method(
          #fetchData,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void updateHabitEntry(
    int? id,
    String? date,
    String? note,
    String? userId,
    String? coachId,
    List<_i7.HabitTask>? habits,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #updateHabitEntry,
          [
            id,
            date,
            note,
            userId,
            coachId,
            habits,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setAppState(_i3.AppState? appState) => super.noSuchMethod(
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
