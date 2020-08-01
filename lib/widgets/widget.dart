import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:forkwalls/model/wallpaper_model.dart';
import 'package:forkwalls/views/categories.dart';
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

class CategoriesTile extends StatelessWidget {
  final String imgUrl, imgtitle;
  CategoriesTile({@required this.imgUrl, this.imgtitle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                      categoryName: imgtitle,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 1),
                height: 85,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(26)),
              height: 80,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                imgtitle,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WallsTile extends StatelessWidget {
  final String imgUrl;
  WallsTile({@required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    String adjRes =
        "?auto=compress&cs=tinysrgb&fit=crop&h=$screenHeight&w=$screenWidth";
    String smallRes = "?auto=compress&cs=tinysrgb&fit=crop&h=585&w=270";

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageView(
                      imgUrl: imgUrl + adjRes,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Hero(
          tag: imgUrl + adjRes,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: CachedNetworkImage(
              imageUrl: imgUrl + smallRes,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline),
              fadeOutDuration: const Duration(seconds: 1),
              fadeInDuration: const Duration(seconds: 1),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
