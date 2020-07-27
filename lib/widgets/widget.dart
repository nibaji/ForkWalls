import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:forkwalls/model/wallpaper_model.dart';
import 'package:forkwalls/views/image.dart';

Widget TheAppName() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
        children: <TextSpan>[
          TextSpan(text: 'F O R K', style: TextStyle(color: Colors.cyan[500])),
          TextSpan(
              text: ' W A L L S',
              style: TextStyle(color: Colors.lightGreen[50])),
        ],
      ),
    ),
  );
}

Widget wallPapersList(List<WallpaperModel> wallpapers, context) {
  double screenWidth = MediaQuery.of(context).size.width * 2.7;
  double screenHeight = MediaQuery.of(context).size.height * 2.4;
  String adjRes =
      "?auto=compress&cs=tinysrgb&fit=crop&h=$screenHeight&w=$screenWidth";
  String smallRes = "?auto=compress&cs=tinysrgb&fit=crop&h=585&w=270";

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgUrl: wallpaper.src.original + adjRes,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.original + adjRes,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.network(
                      wallpaper.src.original + smallRes,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 18),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.blueGrey[800],
                                ),
                              );
                      },
                    )),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
