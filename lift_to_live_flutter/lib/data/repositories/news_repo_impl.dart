import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/domain/repositories/news_repo.dart';

import '../datasources/news_api.dart';

/// Implementation of a News repository (implementing the NewsRepository abstract class)
class NewsRepoImpl implements NewsRepository {
  // Instance of the newsAPI datasource object.
  final NewsAPI newsAPI;

  //Simple constructor for passing the datasource to the repository.
  NewsRepoImpl(this.newsAPI);

  /// This function is used for fetching a News object, containing Articles.
  /// If no news can be fetched, a custom exception is thrown.
  @override
  Future<News> getNews(String search, int count) async {
    //fetch http response object
    Response response = await newsAPI.fetchNews(search, count);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch news success!");

      //return the News object, created from the response body
      return News.fromJson(json.decode(response.body));
    }

    //else throw an exception
    else {
      log("fetch news failed");
      throw FailedFetchException(
          "Failed to fetch news!\nresponse code ${response.statusCode}");
    }
  }
}
