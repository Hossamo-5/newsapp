import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newsapp/models/articles.dart';

class APIS {
 static String APIKE = "82d19f378b6041aeadfb6d6ad1035567";
 static Future<List<Articles>> fetchArticles() async {
    List<Articles> listArticles = [];
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&apiKey=$APIKE");
    print(url);
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body)["articles"];
    print(responsebody);
    for (var i in responsebody) {
      Articles resultApi = Articles(
          description: i["description"],
          title: i["title"],
          url: i["url"],
          urlToImage: i["urlToImage"],
          publishedAt: i["publishedAt"],
          author: i["author"]);
      listArticles.add(resultApi);
    }
    return listArticles;
  }
 static Future<List<Articles>> fetchCategoryArticles(String category) async {
   List<Articles> listArticles = [];
   var url = Uri.parse(
       "https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$APIKE");
   print(url);
   var response = await http.get(url);
   var responseBody = jsonDecode(response.body)["articles"];
   print(responseBody);
   for (var i in responseBody) {
     Articles resultApi = Articles(
         description: i["description"],
         title: i["title"],
         url: i["url"],
         urlToImage: i["urlToImage"],
         publishedAt: i["publishedAt"],
         author: i["author"]);
     listArticles.add(resultApi);
   }
   return listArticles;
 }
}