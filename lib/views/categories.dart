import 'dart:convert';
import 'package:forkwalls/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:forkwalls/data/data.dart';
import 'package:forkwalls/model/wallpaper_model.dart';

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
              wallPapersList(wallpapers, context)
            ],
          ),
        ),
      ),
    );
  }
}
