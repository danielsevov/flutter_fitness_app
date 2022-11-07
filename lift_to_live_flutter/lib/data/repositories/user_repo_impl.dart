import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/domain/entities/image.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/entities/user.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';

import '../datasources/backend_api.dart';
import '../exceptions/fetch_failed_exception.dart';


class UserRepoImpl implements UserRepository {
  @override
  Future<Image> fetchProfileImage(String userId, String jwtToken) async {
    Response response = await BackendAPI.fetchProfileImage(userId, jwtToken);

    if(response.statusCode  == 200) {
      log("fetch profile picture success!");
      return Image.memory(
        base64Decode(MyImage.fromJson(jsonDecode(response.body)[0]).data),
        height: 100,
      );
    }
    else {
      log("fetch profile picture failed");
      throw FetchFailedException("Failed to fetch profile picture!\nresponse code ${response.statusCode}") ;
    }
  }

  @override
  Future<User> fetchUser(String userId, String jwtToken) async {
    Response response = await BackendAPI.fetchUser(userId, jwtToken);

    if(response.statusCode  == 200) {
      log("fetch user details success!");
      return User.fromJson(json.decode(response.body));
    }
    else {
      log("fetch user details failed");
      throw FetchFailedException("Failed to fetch user details!\nresponse code ${response.statusCode}") ;
    }
  }

  @override
  Future<List<Role>> fetchUserRoles(String jwtToken) async {
    Response response = await BackendAPI.fetchUserRoles(jwtToken);

    if(response.statusCode  == 200) {
      log("fetch user roles success!");

      List<Role> myRoles = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        myRoles.add(Role.fromJson(element));
      }

      return myRoles;
    }
    else {
      log("fetch user roles failed");
      throw FetchFailedException("Failed to fetch user roles!\nresponse code ${response.statusCode}") ;
    }
  }


}