import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';

import '../../domain/entities/token.dart';
import '../../domain/repositories/token_repo.dart';
import '../exceptions/fetch_failed_exception.dart';

/// Implementation of a Token repository (implementing the TokenRepository abstract class)
class TokenRepoImpl implements TokenRepository {
  // Instance of the backendAPI datasource object.
  final BackendAPI backendAPI;

  //Simple constructor for passing the datasource to the repository.
  TokenRepoImpl(this.backendAPI);

  /// This function is used for fetching a String JWTToken.
  /// If no token can be fetched, a custom exception is thrown.
  @override
  Future<String> getToken(String email, String password) async {
    //fetch http response object
    Response response = await backendAPI.logIn(email, password);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("log in success!\ntoken:${response.body}");

      //decode Token object and extract JWT string
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var token = Token.fromJson(userMap).token;

      //return the token string, created from the response body
      return token;
    }

    //else throw an exception
    else {
      log("log in failed");
      throw FailedFetchException(
          "Failed to fetch token!\nresponse code ${response.statusCode}");
    }
  }
}
