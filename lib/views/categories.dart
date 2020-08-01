import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:forkwalls/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:forkwalls/data/data.dart';
import 'package:forkwalls/model/wallpaper_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Category extends StatefulWidget {
  final String categoryName;
  Category({this.categoryName});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers = new List();

  getSearchWalls(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80",
        headers: {"Authorization": APIKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWalls(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        //title: TheAppName(),
        title: Text(widget.categoryName),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightGreen[50],
                    borderRadius: BorderRadius.circular(18)),
                padding: EdgeInsets.symmetric(horizontal: 9),
                margin: EdgeInsets.symmetric(horizontal: 15),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 18,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Powered by ',
                          style: TextStyle(color: Colors.lightGreen[200])),
                      TextSpan(
                          text: 'PEXELS',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await launch(
                                ("https://pexels.com"),
                              );
                            },
                          style: TextStyle(color: Colors.cyan[500])),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                child: GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    wallpapers.length,
                    (index) {
                      return WallsTile(
                        imgUrl: wallpapers[index].src.original,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
