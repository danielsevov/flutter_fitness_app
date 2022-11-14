import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/log_in_page.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../domain/entities/news.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/news_repo.dart';
import '../../helper.dart';
import '../state_management/app_state.dart';

import 'package:url_launcher/url_launcher.dart';

/// This is the object, which holds the business logic, related to the Home Page view.
/// It is the mediator between the HomePage view (UI) and the repositories (Data).
class HomePagePresenter {
  HomePageView? _view;
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  late AppState _appState;
  bool _isInitialized = false;
  late User _user;
  late News _currentNews;
  late Image _profilePicture;

  /// Simple constructor for passing the required repositories
  HomePagePresenter(this._newsRepository, this._userRepository);

  /// Function to attach a view to the presenter
  void attach(HomePageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function to pass the app state object to the presenter
  void setAppState(AppState appState) {
    _appState = appState;
    _isInitialized = true;
  }

  /// Getter for the indicator, showing if the presenter has been initialized with the app state object
  bool isInitialized() {
    return _isInitialized;
  }

  /// Function called when user wants to navigate from home to habit page
  void habitsPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(context, const Text("Habits"));
  }

  /// Function called when user wants to navigate from home to profile page
  void profilePressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(context, const Text("Profile"));
  }

  /// Function called when user wants to navigate from home to trainees page
  /// This is only allowed if user is admin or coach.
  void traineesPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    if (isCoachOrAdmin()) {
      Helper.pushPageWithAnimation(context, const Text("Trainees"));
    } else {
      Helper.makeToast(context, "Become coach to access this page!");
    }
  }

  /// Function used for fetching the required data, which is then displayed on the home page.
  Future<void> fetchData() async {

    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    // fetch the user details and profile picture
    _user = await _userRepository.fetchUser(
        _appState.getUserId(), _appState.getToken());
    _profilePicture = await _userRepository.fetchProfileImage(
        _appState.getUserId(), _appState.getToken());

    // display the fetched user data
    _view?.setInProgress(false);
    _view?.setUserData(_user, _profilePicture);
    _view?.setFetched(true);

    // fetch the news
    await fetchNews();
  }

  /// Sub-function to fetch news separately from the user details, as they use different data-sources.
  Future<void> fetchNews() async {

    // display loading indicator on home page
    _view?.setInProgress(true);

    // fetch the news
    _currentNews = await _newsRepository.getNews("bodybuilding", 20);

    // stop the loading indicator and display the news
    _view?.setInProgress(false);
    _view?.setNewsData(_currentNews);
    _view?.setFetched(true);
  }

  /// Function to clear the app state upon log out and navigate to log in page
  void logOut(BuildContext context) {
    _appState.clearState();
    Helper.pushPageWithAnimation(context, const LogInPage());
  }

  /// Function used to open an external browser application and navigate to a news article URL.
  void redirectToURL(int index) async {
    var url = _currentNews.articles[index].url;
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      _view?.notifyWrongURL('Could not launch $url');
    }
  }

  /// Function called to indicate if user is coach or admin.
  isCoachOrAdmin() {
    return _appState.isCoachOrAdmin();
  }
}
