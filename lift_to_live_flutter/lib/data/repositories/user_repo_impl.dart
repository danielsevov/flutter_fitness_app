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

/// Implementation of a User repository (implementing the UserRepository abstract class)
class UserRepoImpl implements UserRepository {

  // Instance of the backendAPI datasource object.
  final BackendAPI backendAPI;

  //Simple constructor for passing the datasource to the repository.
  UserRepoImpl(this.backendAPI);

  /// This function is used for fetching a Image object, which holds the profile picture of a user.
  @override
  Future<Image> fetchProfileImage(String userId, String jwtToken) async {

    //fetch http response object
    Response response = await backendAPI.fetchProfileImage(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if(response.statusCode  == 200) {
      log("fetch profile picture success!");

      //decode image data and return an Image object, created from that data
      return Image.memory(
        base64Decode(MyImage.fromJson(jsonDecode(response.body)[0]).data),
        height: 100,
      );
    }

    //else throw an exception
    else {
      log("fetch profile picture failed");
      throw FetchFailedException("Failed to fetch profile picture!\nresponse code ${response.statusCode}") ;
    }
  }

  /// This function is used for fetching a User object, containing user details.
  @override
  Future<User> fetchUser(String userId, String jwtToken) async {

    //fetch http response object
    Response response = await backendAPI.fetchUser(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if(response.statusCode  == 200) {
      log("fetch user details success!");

      //return the User object, created from the response body
      return User.fromJson(json.decode(response.body));
    }

    //else throw an exception
    else {
      log("fetch user details failed");
      throw FetchFailedException("Failed to fetch user details!\nresponse code ${response.statusCode}") ;
    }
  }

  /// This function is used for fetching a list of Role objects, describing the user role of a user.
  @override
  Future<List<Role>> fetchUserRoles(String jwtToken) async {

    //fetch http response object
    Response response = await backendAPI.fetchUserRoles(jwtToken);

    //proceed if fetch is successful and status code is 200
    if(response.statusCode  == 200) {
      log("fetch user roles success!");

      //decode response body and create a list of Role objects
      List<Role> myRoles = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        myRoles.add(Role.fromJson(element));
      }

      //return the list of Role objects
      return myRoles;
    }

    //else throw an exception
    else {
      log("fetch user roles failed");
      throw FetchFailedException("Failed to fetch user roles!\nresponse code ${response.statusCode}") ;
    }
  }


}