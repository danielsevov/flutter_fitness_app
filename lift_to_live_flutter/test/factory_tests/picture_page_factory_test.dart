import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/factory/picture_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/picture_page_presenter.dart';

void main() {
  test('PicturePageFactory.getUserRepository() test', () {
    var repo = PicturePageFactory().getUserRepository();

    expect(repo, isA<UserRepository>());
  });

  test('PicturePageFactory.getPicturePagePresenter() test', () {
    var presenter = PicturePageFactory().getPicturePagePresenter('email@email.com');

    expect(presenter, isA<PicturePagePresenter>());
  });
}
