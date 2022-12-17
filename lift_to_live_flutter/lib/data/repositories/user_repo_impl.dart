import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/exceptions/duplicated_id_exception.dart';
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

  /// This function is used for patching a Image object, which holds the picture of a user.
  @override
  Future<void> patchImage(int id, String userId, String date, String data,
      String type, String token) async {
    //fetch http response object
    Response response =
        await backendAPI.patchImage(id, userId, date, data, type, token);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200 || response.body.contains('SUCCESS')) {
      log("patch image success!");
    }

    //else throw an exception
    else {
      log("patch image failed");
      throw FailedFetchException(
          "Failed to patch image!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for posting a Image object, which holds the picture of a user.
  @override
  Future<void> postImage(String userId, String date, String data, String type,
      String token) async {
    var response = await backendAPI.postImage(userId, date, data, type, token);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200 || response.body.contains('SUCCESS')) {
      log("post image success!");
    }

    //else throw an exception
    else {
      log("post image failed");
      throw FailedFetchException(
          "Failed to post image!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching a Image object, which holds the profile picture of a user.
  @override
  Future<MyImage> fetchProfileImage(String userId, String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchProfileImage(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch profile picture success!");

      //decode image data and return an Image object, created from that data
      return MyImage.fromJson(jsonDecode(response.body)[0]);
    }

    //else throw an exception
    else {
      log("fetch profile picture failed");
      throw FailedFetchException(
          "Failed to fetch profile picture!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching a User object, containing user details.
  @override
  Future<User> fetchUser(String userId, String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchUser(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch user details success!");

      //return the User object, created from the response body
      return User.fromJson(json.decode(response.body));
    }

    //else throw an exception
    else {
      log("fetch user details failed");
      throw FailedFetchException(
          "Failed to fetch user details!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching all trainees profiles of the current user.
  @override
  Future<List<User>> fetchMyTrainees(String userId, String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchMyTrainees(jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch trainee details success!");

      //decode response body and create a list of User objects
      List<User> myTrainees = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        myTrainees.add(User.fromJson(element));
      }
      return myTrainees;
    }

    //else throw an exception
    else {
      log("fetch trainee details failed");
      throw FailedFetchException(
          "Failed to fetch user details!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching all Image objects of a user.
  @override
  Future<List<MyImage>> fetchUserImages(String userId, String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchImages(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch user images success!");

      //decode response body and create a list of MyImage objects
      List<MyImage> myImages = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        myImages.add(MyImage.fromJson(element));
      }

      //return the list of MyImage objects
      return myImages;
    }

    //else throw an exception
    else {
      log("fetch user images failed");
      throw FailedFetchException(
          "Failed to fetch user images!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching a list of Role objects, describing the user role of a user.
  @override
  Future<List<Role>> fetchUserRoles(String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchUserRoles(jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
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
      throw FailedFetchException(
          "Failed to fetch user roles!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching a list of all coach Role objects.
  @override
  Future<List<Role>> fetchCoachRoles(String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchCoachRoles(jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch coach roles success!");

      //decode response body and create a list of Role objects
      List<Role> coachRoles = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        var r = Role.fromJson(element);
        coachRoles.add(r);
        log(r.userId);
      }

      //return the list of Role objects
      return coachRoles;
    }

    //else throw an exception
    else {
      log("fetch coach roles failed");
      throw FailedFetchException(
          "Failed to fetch coach roles!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used to delete a image.
  @override
  Future<void> deleteImage(int id, String jwtToken) async {
    try {
      var res = await backendAPI.deleteImage(id, jwtToken);

      if (res.statusCode != 200 && res.statusCode != 204) {
        log("fetch user details failed");
        throw FailedFetchException("Failed to delete image!");
      }
    } catch (e) {
      log("fetch user details failed");
      throw FailedFetchException("Failed to delete image!\n$e");
    }
  }

  /// This function is used for registering a user.
  @override
  Future<void> registerUser(
      String userId,
      String coachId,
      String password,
      String name,
      String phoneNumber,
      String nationality,
      String dateOfBirth,
      String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.registerUser(userId, coachId, password,
        name, phoneNumber, nationality, dateOfBirth, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("post user success!");
    }
    // check if register failed due to duplicated id
    else if (response.statusCode == 409) {
      log("duplicated user id, post user failed!");
      throw DuplicatedIdException(
          "Failed to register new user!\nresponse code ${response.statusCode}");
    }
    //else throw an exception
    else {
      log("post user failed");
      throw FailedFetchException(
          "Failed to register new user!\nresponse code ${response.statusCode}");
    }
  }
}
