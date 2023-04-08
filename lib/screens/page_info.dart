import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_pilot/utils/app_theme.dart';
class ActuInfo extends StatelessWidget {
  const ActuInfo({Key? key, required this.title, required this.description, required this.pubdate, required this.guid}) : super(key: key);
  final String title,description,pubdate,guid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: Text(title,style: GoogleFonts.outfit(color: primaryColor,fontSize: 20,fontWeight: FontWeight.w800),textAlign: TextAlign.center,)
              ),
              Text(description,style: GoogleFonts.outfit(color: thirdColor,fontSize: 25,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
              Column(
                children: [
                  Text(guid,style: GoogleFonts.outfit(color: secondaryColor,fontSize: 12),textAlign: TextAlign.center,softWrap: true,),
                  Text(pubdate,style: GoogleFonts.outfit(color: secondaryColor,fontSize: 12),textAlign: TextAlign.end,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
