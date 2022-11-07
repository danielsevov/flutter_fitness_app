import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';
import 'package:lift_to_live_flutter/domain/repositories/news_repo.dart';

class NewsRepoImpl implements NewsRepository {

  @override
  Future<News> getNews() async {
    Response response = await BackendAPI.fetchNews("bodybuilding", 20);

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