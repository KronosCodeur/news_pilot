import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_pilot/screens/page_info.dart';
import 'package:news_pilot/utils/app_theme.dart';
import 'package:webfeed/webfeed.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.items, required this.title}) : super(key: key);
  final List<RssItem>? items;
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 2,
        title: Text(
          widget.title,
          style: GoogleFonts.outfit(
            color: appWhite,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: widget.items?.length == 0
          ? Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
                strokeWidth: 2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ListView.builder(
                itemCount: widget.items?.length,
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
                            blurRadius: 2.0)
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActuInfo(
                                title: "${widget.items?[index].title}",
                                description:
                                    "${widget.items?[index].description}",
                                pubdate:
                                    "${widget.items?[index].pubDate.toString().substring(0, 16)}",
                                guid: "${widget.items?[index].guid}",
                              ),
                            ));
                      },
                      style: ListTileStyle.list,
                      horizontalTitleGap: 5,
                      title: Text(
                        "${widget.items?[index].title}",
                        style: GoogleFonts.outfit(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "${widget.items?[index].pubDate.toString().substring(0, 16)}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                            color: thirdColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                },
              )),
            ),
    );
  }
}
