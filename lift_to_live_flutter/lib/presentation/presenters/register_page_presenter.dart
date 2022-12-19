import 'dart:developer';

import 'package:lift_to_live_flutter/data/exceptions/duplicated_id_exception.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';

import '../views/register_page_view.dart';

/// This is the object, which holds the business logic, related to the Register user Page view.
/// It is the mediator between the Register view (UI) and the repositories (Data).
class RegisterPagePresenter extends BasePresenter {
  RegisterPageView? _view; // the log in view UI component
  late final UserRepository
      _userRepository; // the repository used for fetching the user roles

  /// Simple constructor
  RegisterPagePresenter();

  /// Function to attach repositories
  void attachRepositories(UserRepository userRepository) {
    _userRepository = userRepository;
    super.repositoriesAttached = true;
  }

  /// Function to attach a view to the presenter
  void attach(RegisterPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function used for fetching the required data, which is then displayed on the register page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the register page view
    _view?.setInProgress(true);

    // fetch the user ids of the coaches
    var coachesIds = <String>[];
    try {
      var coaches = await _userRepository.fetchCoachRoles(appState.getToken());
      coachesIds = coaches.map((e) => e.userId).toList();
      if (!appState.isCoach()) {
        coachesIds.add(appState.getUserId());
      }
    } catch (e) {
      _view?.notifyRegisterFailed();
    }

    // display the fetched user data
    _view?.setInProgress(false);
    _view?.setCoachData(coachesIds);
    _view?.setFetched(true);
  }

  /// Function, which is called upon submission and handles the registration of the user.
  Future<void> registerUser() async {
    // set the loading indicator to be shown on the page view
    _view?.setInProgress(true);

    // extract the email and password entries from the log in form
    String? email = _view?.getRegisterForm().getEmail(),
        pass = _view?.getRegisterForm().getPassword(),
        name = _view?.getRegisterForm().getName(),
        nationality = _view?.getRegisterForm().getNationality(),
        phoneNumber = _view?.getRegisterForm().getPhoneNumber(),
        birthday = _view?.getRegisterForm().getDateOfBirth(),
        coachId = _view?.getRegisterForm().getCoachEmail();

    // try to register user
    try {
      log('email: $email, pass: $pass, name: $name, nationality: $nationality, phoneNumber: $phoneNumber, birthday: $birthday, coachId: $coachId');
      await _userRepository.registerUser(email!, coachId!, pass!, name!,
          phoneNumber!, nationality!, birthday!, appState.getToken());

      _view?.setInProgress(false);
      _view?.notifyUserRegistered();
    } on DuplicatedIdException {
      _view?.getRegisterForm().clearEmail();
      _view?.notifyEmailAlreadyExists();
    } catch (e) {
      _view?.getRegisterForm().clearPassword();
      _view?.notifyRegisterFailed();
    }

    // stop the loading indicator as data processing is finished
    _view?.setInProgress(false);
  }
}
