// Mocks generated by Mockito 5.3.2 from annotations
// in lift_to_live_flutter/test/repository_tests/token_repo_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:http/http.dart' as _i2;
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart' as _i3;
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart' as _i6;
import 'package:lift_to_live_flutter/domain/entities/workout_set.dart' as _i5;
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

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BackendAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockBackendAPI extends _i1.Mock implements _i3.BackendAPI {
  MockBackendAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response> patchImage(
    int? id,
    String? userId,
    String? date,
    String? data,
    String? type,
    String? token,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #patchImage,
          [
            id,
            userId,
            date,
            data,
            type,
            token,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patchImage,
            [
              id,
              userId,
              date,
              data,
              type,
              token,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchImages(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchImages,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchImages,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> deleteImage(
    int? id,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteImage,
          [
            id,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #deleteImage,
            [
              id,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchWorkouts(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWorkouts,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchWorkouts,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchWorkoutTemplates(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWorkoutTemplates,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchWorkoutTemplates,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> deleteWorkout(
    int? id,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteWorkout,
          [
            id,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #deleteWorkout,
            [
              id,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> postWorkout(
    String? coachNote,
    String? note,
    String? userId,
    String? coachId,
    List<_i5.WorkoutSet>? sets,
    String? completedOn,
    String? createdOn,
    String? name,
    String? duration,
    bool? isTemplate,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postWorkout,
          [
            coachNote,
            note,
            userId,
            coachId,
            sets,
            completedOn,
            createdOn,
            name,
            duration,
            isTemplate,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #postWorkout,
            [
              coachNote,
              note,
              userId,
              coachId,
              sets,
              completedOn,
              createdOn,
              name,
              duration,
              isTemplate,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> patchWorkout(
    int? id,
    String? coachNote,
    String? note,
    String? userId,
    String? coachId,
    List<_i5.WorkoutSet>? sets,
    String? completedOn,
    String? createdOn,
    String? name,
    String? duration,
    bool? isTemplate,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #patchWorkout,
          [
            id,
            coachNote,
            note,
            userId,
            coachId,
            sets,
            completedOn,
            createdOn,
            name,
            duration,
            isTemplate,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patchWorkout,
            [
              id,
              coachNote,
              note,
              userId,
              coachId,
              sets,
              completedOn,
              createdOn,
              name,
              duration,
              isTemplate,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> postImage(
    String? userId,
    String? date,
    String? data,
    String? type,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postImage,
          [
            userId,
            date,
            data,
            type,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #postImage,
            [
              userId,
              date,
              data,
              type,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> patchHabit(
    int? id,
    String? date,
    String? note,
    String? userId,
    String? coachId,
    List<_i6.HabitTask>? habits,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #patchHabit,
          [
            id,
            date,
            note,
            userId,
            coachId,
            habits,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patchHabit,
            [
              id,
              date,
              note,
              userId,
              coachId,
              habits,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchHabitTemplate(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchHabitTemplate,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchHabitTemplate,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchHabits(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchHabits,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchHabits,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> postHabit(
    String? date,
    String? note,
    String? userId,
    String? coachId,
    bool? isTemplate,
    List<_i6.HabitTask>? habits,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postHabit,
          [
            date,
            note,
            userId,
            coachId,
            isTemplate,
            habits,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #postHabit,
            [
              date,
              note,
              userId,
              coachId,
              isTemplate,
              habits,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> logIn(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #logIn,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> registerUser(
    String? userId,
    String? coachId,
    String? password,
    String? name,
    String? phoneNumber,
    String? nationality,
    String? dateOfBirth,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [
            userId,
            coachId,
            password,
            name,
            phoneNumber,
            nationality,
            dateOfBirth,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #registerUser,
            [
              userId,
              coachId,
              password,
              name,
              phoneNumber,
              nationality,
              dateOfBirth,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchUserRoles(String? jwtToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserRoles,
          [jwtToken],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchUserRoles,
            [jwtToken],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchCoachRoles(String? jwtToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchCoachRoles,
          [jwtToken],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchCoachRoles,
            [jwtToken],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchUsers(String? jwtToken) => (super.noSuchMethod(
        Invocation.method(
          #fetchUsers,
          [jwtToken],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchUsers,
            [jwtToken],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchMyTrainees(String? jwtToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchMyTrainees,
          [jwtToken],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchMyTrainees,
            [jwtToken],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchUser(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUser,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchUser,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> fetchProfileImage(
    String? userId,
    String? jwtToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchProfileImage,
          [
            userId,
            jwtToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #fetchProfileImage,
            [
              userId,
              jwtToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
}
