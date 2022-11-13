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

class HomePresenter {
  HomePageView? _view;
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  late AppState _appState;
  bool _isInitialized = false;
  late User _user;
  late News _currentNews;
  late Image _profilePicture;

  HomePresenter(this._newsRepository, this._userRepository);

  void attach(HomePageView view) {
    _view = view;
  }

  void detach() {
    _view = null;
  }

  void setAppState(AppState appState) {
    _appState = appState;
    _isInitialized = true;
  }

  bool isInitialized() {
    return _isInitialized;
  }

  void habitsPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(context, const Text("Habits"));
  }

  void profilePressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    Helper.pushPageWithAnimation(context, const Text("Profile"));
  }

  void traineesPressed(BuildContext context, bool bottomBarButton) {
    if (!bottomBarButton) Navigator.of(context).pop();
    if (isCoachOrAdmin()) {
      Helper.pushPageWithAnimation(context, const Text("Trainees"));
    } else {
      Helper.makeToast(context, "Become coach to access this page!");
    }
  }

  Future<void> fetchData() async {
    _view?.setInProgress(true);

    _user = await _userRepository.fetchUser(
        _appState.getUserId(), _appState.getToken());
    _profilePicture = await _userRepository.fetchProfileImage(
        _appState.getUserId(), _appState.getToken());
    _currentNews = await _newsRepository.getNews("bodybuilding", 20);

    _view?.setInProgress(false);
    _view?.setData(_user, _profilePicture, _currentNews);
    _view?.setFetched(true);
  }

  void logOut(BuildContext context) {
    _appState.clearState();
    Helper.pushPageWithAnimation(context, const LogInPage());
  }

  void redirectToURL(int index) async {
    var url = _currentNews.articles[index].url;
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      _view?.notifyWrongURL('Could not launch $url');
    }
  }

  isCoachOrAdmin() {
    return _appState.isCoachOrAdmin();
  }
}
