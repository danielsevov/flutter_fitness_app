// coverage:ignore-start

import 'package:flutter/material.dart';

/// API to the PicturePage view widget.
/// Describes the methods of the pictures page view implementation.
abstract class PicturePageView {
  /// Function to set and display the user details, user pictures.
  void setPictures(List<Widget> pictureSide, List<Widget> pictureFront,
      List<Widget> pictureBack);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to add a new image entry.
  void addNewPicture(Image img, String type);
}

// coverage:ignore-end
