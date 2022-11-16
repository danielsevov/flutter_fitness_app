import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../domain/entities/news.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/news_repo.dart';

import 'package:url_launcher/url_launcher.dart';

/// This is the object, which holds the business logic, related to the Home Page view.
/// It is the mediator between the HomePage view (UI) and the repositories (Data).
class HomePagePresenter extends BasePresenter{
  HomePageView? _view;
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
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

  /// Function called to indicate if user is coach or admin.
  isCoachOrAdmin() {
    return super.appState.isCoachOrAdmin();
  }

  /// Function to clear the app state upon log out and navigate to log in page
  void logOut() {
    super.appState.clearState();
  }

  /// Function used for fetching the required data, which is then displayed on the home page.
  Future<void> fetchData() async {

    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    // fetch the user details and profile picture
    _user = await _userRepository.fetchUser(
        super.appState.getUserId(), super.appState.getToken());
    _profilePicture = await _userRepository.fetchProfileImage(
        super.appState.getUserId(), super.appState.getToken());

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

  /// Function used to open an external browser application and navigate to a news article URL.
  Future<void> redirectToURL(int index) async {
    var url = _currentNews.articles[index].url;
    try {
      if (url.length >= 5 && !await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        _view?.notifyWrongURL('Could not launch $url');
      }
    }
    catch(e) {
      _view?.notifyWrongURL('Could not launch $url');
    }
  }
}
