import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';

import '../mock_data.dart';

void main() {
  test('AppState constructor test', () {
    final appState = AppState();
    expect(appState.hasState(), false);
  });

  test('AppState set state and state getter functions test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [MockData.testRole1]);
    expect(appState.hasState(), true);
    expect(appState.getToken(), 'token');
    expect(appState.getUserRoles(), [MockData.testRole1]);
    expect(appState.getUserId(), 'email');
  });

  test('AppState clear state test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [MockData.testRole1]);
    expect(appState.hasState(), true);
    appState.clearState();
    expect(appState.hasState(), false);
  });

  test('AppState isAdmin test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    expect(appState.isAdmin(), true);
  });

  test('AppState isCoach test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [Role('email', 'coach')]);
    expect(appState.isCoach(), true);
  });

  test('AppState is not a coach test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    expect(appState.isCoach(), false);
  });

  test('AppState is not an admin test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [Role('email', 'coach')]);
    expect(appState.isAdmin(), false);
  });

  test('AppState isAdminOrCoach test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    expect(appState.isCoachOrAdmin(), true);
  });

  test('AppState is not AdminOrCoach test', () {
    final appState = AppState();

    expect(appState.hasState(), false);
    appState.setInitialState('email', 'token', []);

    final c = appState.isCoach();
    final a = appState.isAdmin();
    final ac = appState.isCoachOrAdmin();

    expect(c && a && ac, false);
  });
}
