import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/image.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import '../../domain/entities/user.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper.dart';
import '../views/profile_page_view.dart';

/// This is the object, which holds the business logic, related to the user Profile Page view.
/// It is the mediator between the ProfilePage view (UI) and the repositories (Data).
class ProfilePagePresenter extends BasePresenter{
  ProfilePageView? _view;

  final UserRepository _userRepository;
  final String _userId;
  late User _user;

  late MyImage _myImage;
  late Image _profilePicture;

  /// Simple constructor for passing the required repositories
  ProfilePagePresenter(this._userRepository, this._userId);

  /// Function to attach a view to the presenter
  void attach(ProfilePageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to view private pages.
  isAuthorized() {
    return appState.getUserId() == _userId || super.appState.isCoachOrAdmin();
  }

  /// Function used for fetching the required data, which is then displayed on the profile page.
  Future<void> fetchData() async {

    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    // fetch the user details and profile picture
    try {
      _user = await _userRepository.fetchUser(
          _userId, super.appState.getToken());

      try {
        _myImage = await _userRepository.fetchProfileImage(
            _userId, super.appState.getToken());
        _profilePicture = Image.memory(
          base64Decode(_myImage.data),
          height: 300,
        );
      }
      catch (e) {
        _myImage = MyImage('', 'profile', 0, '', '');
        _profilePicture = Image.asset('assets/images/prof_pic.png', height: 300, color: Helper.yellowColor,);
      }

      // display the fetched user data
      _view?.setInProgress(false);
      _view?.setUserData(_user, _profilePicture);
    }
    catch (e) {
      _view?.notifyNoUserData();
      _view?.setInProgress(false);
    }
  }

  // coverage:ignore-start
  /// Function used for picking a new profile picture, storing it and displaying it on the profile page.
  changeProfilePicture() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String encoded = Helper.imageToBlob(imageFile);

      if(_myImage.id != 0) {
        _userRepository.patchImage(_myImage.id, _myImage.userId, (DateTime.now().millisecondsSinceEpoch).toString(), encoded, "profile", appState.getToken());
      }
      else {
        _userRepository.postImage(_myImage.userId, (DateTime.now().millisecondsSinceEpoch).toString(), encoded, "profile", appState.getToken());
      }

      var img = Image.file(
        imageFile,
        height: 300,
      );

      _view?.changeProfilePicture(img);
    }
  }
// coverage:ignore-end
}
