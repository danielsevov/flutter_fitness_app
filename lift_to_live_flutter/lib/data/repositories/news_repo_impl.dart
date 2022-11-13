import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/domain/repositories/news_repo.dart';

class NewsRepoImpl implements NewsRepository {
  final BackendAPI backendAPI;

  NewsRepoImpl(this.backendAPI);

  @override
  Future<News> getNews(String search, int count) async {
    Response response = await backendAPI.fetchNews(search, count);

    if(response.statusCode  == 200) {
      log("fetch news success!");

      return News.fromJson(json.decode(response.body));
    }
    else {
      log("fetch news failed");
      throw FetchFailedException("Failed to fetch news!\nresponse code ${response.statusCode}");
    }
  }

}