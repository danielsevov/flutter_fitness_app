import 'dart:developer';
import 'package:lift_to_live_flutter/domain/entities/image.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/user_related/trainee_search_holder.dart';
import '../../domain/entities/user.dart';
import '../views/trainees_page_view.dart';

/// This is the object, which holds the business logic, related to the user Trainees Page view.
/// It is the mediator between the TraineesPage view (UI) and the repositories (Data).
class TraineesPagePresenter extends BasePresenter{
  TraineesPageView? _view;

  final UserRepository _userRepository;
  late final List<User> _users;

  /// Simple constructor for passing the required repositories
  TraineesPagePresenter(this._userRepository);

  /// Function to attach a view to the presenter
  void attach(TraineesPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to search trainees.
  isAuthorized() {
    return super.appState.isCoachOrAdmin();
  }

  /// Function used for fetching the required data, which is then displayed on the trainees search page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the trainees page view
    _view?.setInProgress(true);

    // fetch the user details and profile picture
    try {
      _users = await _userRepository.fetchMyTrainees(appState.getUserId(), appState.getToken());

      List<TraineeSearchHolder> widgets = [];
      MyImage currentImage;
      for (var element in _users) {

        try{
          currentImage = await _userRepository.fetchProfileImage(element.id, appState.getToken());
          element.profilePicture = currentImage;
        }
        catch(e) {
          log('missing profile picture');
        }

        widgets.add(TraineeSearchHolder(user: element, view: _view!,));
      }

      log('reached here');
      _view?.setInProgress(false);
      _view?.setUserData(widgets);
      _view?.setFetched(true);
    }
    catch (e) {
      _view?.notifyNoUserData();
      _view?.setInProgress(false);
    }
  }
}
