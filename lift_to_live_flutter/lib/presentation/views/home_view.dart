import 'package:flutter/material.dart';

import '../../domain/entities/news.dart';
import '../../domain/entities/user.dart';

abstract class HomeView {
  void setData(User user, Image profilePicture, News currentNews);

  void setInProgress(bool inProgress);

  void setFetched(bool fetched) {}

  void notifyWrongURL(String s) {}
}