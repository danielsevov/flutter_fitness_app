import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';

import '../../domain/entities/token.dart';
import '../../domain/repositories/token_repo.dart';
import '../exceptions/fetch_failed_exception.dart';

class TokenRepoImpl implements TokenRepository {
  final BackendAPI backendAPI;

  TokenRepoImpl(this.backendAPI);

  @override
  Future<String> getToken(String email, String password) async {
    Response response = await backendAPI.logIn(email, password);

    if(response.statusCode  == 200) {
      log("log in success!\ntoken:${response.body}");

      Map<String, dynamic> userMap = jsonDecode(response.body);
      var token = Token.fromJson(userMap).token;

      return token;
    }
    else {
      log("log in failed");
      throw FetchFailedException("Failed to fetch token!\nresponse code ${response.statusCode}");
    }
  }

}