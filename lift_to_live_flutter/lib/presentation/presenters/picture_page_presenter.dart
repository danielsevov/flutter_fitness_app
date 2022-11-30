import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/image.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/my_image_holder.dart';
import '../../helper.dart';
import '../views/picture_page_view.dart';

/// This is the object, which holds the business logic, related to the user Picture Page view.
/// It is the mediator between the PicturePage view (UI) and the repositories (Data).
class PicturePagePresenter extends BasePresenter{
  PicturePageView? _view;

  final UserRepository _userRepository;
  final String _userId;

  List<MyImage> _myImages = [];
  List<Image> _pictures = [];

  /// Simple constructor for passing the required repositories
  PicturePagePresenter(this._userRepository, this._userId);

  /// Function to attach a view to the presenter
  void attach(PicturePageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to add pictures.
  isAuthorized() {
    return appState.getUserId() == _userId;
  }

  /// Function used for fetching the required data, which is then displayed on the profile page.
  Future<void> fetchData() async {

    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    _myImages = [];
    _pictures = [];
    var sPics = <Widget>[], bPics = <Widget>[], fPics = <Widget>[];

      try {
        _myImages = await _userRepository.getUserImages(
            _userId, super.appState.getToken());

        for (var element in _myImages) {
          _pictures.add(Image.memory(
            base64Decode(element.data),
            height: 200,
          ));

          if(element.type == 'side') {
            sPics.add(MyImageHolder(img: Image.memory(
              base64Decode(element.data),
              height: 200,
            ), date: element.date, id: element.id, presenter: this));
          }

          if(element.type == 'back') {
            bPics.add(MyImageHolder(img: Image.memory(
              base64Decode(element.data),
              height: 200,
            ), date: element.date, id: element.id, presenter: this));
          }

          if(element.type == 'front') {
            fPics.add(MyImageHolder(img: Image.memory(
              base64Decode(element.data),
              height: 200,
            ), date: element.date, id: element.id, presenter: this));
          }
        }
      }
      catch (e) {
        _myImages = [];
        _pictures = [];
      }

      // display the fetched user data
      _view?.setInProgress(false);
      _view?.setPictures(sPics, bPics, fPics);
  }

  // coverage:ignore-start
  /// Function used for picking a new profile picture, storing it and displaying it on the picture page.
  addPicture(String type) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String encoded = Helper.imageToBlob(imageFile);

        await _userRepository.postImage(_userId, (DateTime.now().millisecondsSinceEpoch).toString(), encoded, type, appState.getToken());

      fetchData();
    }
  }

  Future<void> deleteImage(int id) async {
    await _userRepository.deleteImage(id, super.appState.getToken());
    fetchData();
  }
// coverage:ignore-end
}
