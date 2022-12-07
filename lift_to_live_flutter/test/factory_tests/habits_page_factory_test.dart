import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/factory/habits_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/edit_habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart';

void main() {
  test('HabitsPageFactory.getHabitsRepository() test', () {
    var repo = HabitsPageFactory().getHabitsRepository();

    expect(repo, isA<HabitsRepository>());
  });

  test('HabitsPageFactory.getHabitsPagePresenter() test', () {
    var presenter = HabitsPageFactory().getHabitsPagePresenter('email@email.com');

    expect(presenter, isA<HabitsPagePresenter>());
  });

  test('EditHabitsPageFactory.getEditHabitsPagePresenter() test', () {
    var presenter = HabitsPageFactory().getEditHabitsPagePresenter('email@email.com');

    expect(presenter, isA<EditHabitsPagePresenter>());
  });
}
