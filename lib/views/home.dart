import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:forkwalls/model/categories_model.dart';
import 'package:forkwalls/model/wallpaper_model.dart';
import 'package:forkwalls/views/search.dart';
import 'package:forkwalls/data/data.dart';
import 'package:forkwalls/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWalls() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=80",
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
    getTrendingWalls();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: TheAppName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightGreen[50],
                    borderRadius: BorderRadius.circular(25)),
                padding: EdgeInsets.symmetric(horizontal: 9),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "search walls", border: InputBorder.none),
                      onSubmitted: (search) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                      searchQuery: searchController.text,
                                    )));
                      },
                    )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                        searchQuery: searchController.text,
                                      )));
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
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
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        imgtitle: categories[index].CategoryName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
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
