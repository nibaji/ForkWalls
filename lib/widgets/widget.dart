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
                            imgUrl: wallpaper.src.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : LinearProgressIndicator(
                                backgroundColor: Colors.blueGrey[800],
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
