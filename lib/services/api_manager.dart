import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_api/constants/strings.dart';
import 'package:movie_api/models/newsInfo.dart';

class ApiManager {
  Future<News> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Strings.newsUrl);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);//decode json
        newsModel = News.fromJson(jsonMap);//map json to news model
      }
      return newsModel;
    }
    catch (Exception) {
      return newsModel;
    }
  }
}
