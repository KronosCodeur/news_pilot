import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class Parser {
  Future chargerRSS(String url)async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final feed = RssFeed.parse(response.body);
      return feed;
    }else{
      print("erreur: ${response.statusCode}");
    }
  }
}
