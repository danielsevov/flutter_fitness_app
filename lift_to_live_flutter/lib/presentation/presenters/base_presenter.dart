import '../state_management/app_state.dart';

/// This is a base class for all presenters.
abstract class BasePresenter {
  late AppState _appState; // the app state object
  bool _isInitialized =
      false; // indicator if the presenter has been initialized with the app state object yet
  bool _repositoriesAttached = false; // indicates if the required repositories are attached and the presenter is ready for use

  /// Getter and setter functions for repositoriesAttached
  bool get repositoriesAttached => _repositoriesAttached;

  set repositoriesAttached(value) {
    _repositoriesAttached = value;
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

  /// Getter for appState
  AppState get appState => _appState;
}
