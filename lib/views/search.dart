import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:forkwalls/data/data.dart';
import 'package:forkwalls/model/wallpaper_model.dart';
import 'package:forkwalls/widgets/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getSearchWalls(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80",
        headers: {"Authorization": APIKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    wallpapers = new List();
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWalls(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        //title: TheAppName(),
        title: Text("Search"),
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "search walls", border: InputBorder.none),
                      onSubmitted: (search) {
                        getSearchWalls(searchController.text);
                      },
                    )),
                    GestureDetector(
                        onTap: () {
                          getSearchWalls(searchController.text);
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
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
