import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_pilot/screens/home.dart';
import 'package:news_pilot/services/parser.dart';
import 'package:news_pilot/utils/app_theme.dart';
import 'package:webfeed/webfeed.dart';
class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List listOfUrl = [
    {"name": "Sciences", "url": "https://www.lemonde.fr/sciences/rss_full.xml"},
    {"name": "Gastronomie", "url": "https://www.lemonde.fr/gastronomie/rss_full.xml"},
    {"name": "Jeux Vidéos", "url": "https://www.lemonde.fr/jeux-video/rss_full.xml"},
    {"name": "Physique", "url": "https://www.lemonde.fr/physique/rss_full.xml"},
    {"name": "Cultures Web", "url": "https://www.lemonde.fr/cultures-web/rss_full.xml"},
    {"name": "Basket", "url": "https://www.lemonde.fr/basket/rss_full.xml"},
    {"name": "Cinema", "url": "https://www.lemonde.fr/cinema/rss_full.xml"},
    {"name": "Livres", "url": "https://www.lemonde.fr/livres/rss_full.xml"},
    {"name": "Actu Afrique", "url": "https://www.lemonde.fr/afrique/rss_full.xml"},
  ];
  RssFeed feed  = RssFeed();
  List <RssItem>? items = [];
  bool _isLoading = false;
  @override
  void initState() {
    items = [];
    _isLoading=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 2,
        title: Text(
          "News Pilot",
          style:GoogleFonts.outfit(
            color: appWhite,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body:_isLoading?Center(child: CircularProgressIndicator(color: primaryColor,strokeWidth: 2,),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ListView.builder(
              itemCount: listOfUrl.length,
              dragStartBehavior: DragStartBehavior.start,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: appWhite,
                    boxShadow: [
                      BoxShadow(
                          color: thirdColor.withOpacity(0.5),
                          offset: Offset(1, 1),
                          spreadRadius: 2.0,
                          blurRadius: 2.0
                      )
                    ],
                  ),
                  child: ListTile(
                    onTap: () async {
                      await parse(listOfUrl[index]["url"]).then((value){
                        setState(() {
                          items = value;
                        });
                      });
                      if(items?.length==0){
                        setState(() {
                          _isLoading=true;
                        });
                      }else{
                        setState(() {
                          _isLoading=false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(title: "${listOfUrl[index]["name"]}",items: items,),));
                      }
                    },
                    style: ListTileStyle.list,
                    horizontalTitleGap: 5,
                    title: Text("${listOfUrl[index]["name"]}",style: GoogleFonts.outfit(color: primaryColor,fontSize: 18,fontWeight: FontWeight.w700),textAlign: TextAlign.center,softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,),
                  ),
                );
              },
            )
        ),
      ),
    );
  }
  Future parse(String url) async{
    _isLoading=true;
    RssFeed response = await Parser().chargerRSS(url);
    return response.items;
  }
}
