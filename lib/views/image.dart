import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imgUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : LinearProgressIndicator(
                          backgroundColor: Colors.blueGrey[800],
                        );
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _chechAndAskPermission();
                    await _save();
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        border:
                            Border.all(color: Colors.lightGreen[200], width: 1),
                        borderRadius: BorderRadius.circular(26)),
                    width: MediaQuery.of(context).size.width / 4,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Column(
                      children: [
                        Text(
                          "Save Image",
                          style: TextStyle(
                              color: Colors.lightGreen[100],
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () async {
                    setWallpaperDialog();
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        border:
                            Border.all(color: Colors.lightGreen[200], width: 1),
                        borderRadius: BorderRadius.circular(26)),
                    width: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Column(
                      children: [
                        Text(
                          "Set as Wallpaper",
                          style: TextStyle(
                              color: Colors.lightGreen[100],
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Future<bool> _chechAndAskPermission() async {
    final PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissions =
          await [Permission.storage].request();
      if (permissions[Permission.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }

  _save() async {
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Fluttertoast.showToast(
        msg: "Image is saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.lightGreen[100],
        fontSize: 14.0);
  }

  void setWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black54,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black54,
                border: Border.all(color: Colors.lightGreen[200], width: 2),
                borderRadius: BorderRadius.circular(26)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Set Wallpaper for',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen[200],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Home Screen',
                    style: TextStyle(color: Colors.lightGreen[50]),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.lightGreen[100],
                  ),
                  onTap: () async {
                    await _setAsHome();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Lock Screen',
                    style: TextStyle(color: Colors.lightGreen[50]),
                  ),
                  leading: Icon(
                    Icons.lock,
                    color: Colors.lightGreen[100],
                  ),
                  onTap: () async {
                    await _setAsLock();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Both',
                    style: TextStyle(color: Colors.lightGreen[50]),
                  ),
                  leading: Icon(
                    Icons.phone_android,
                    color: Colors.lightGreen[100],
                  ),
                  onTap: () async {
                    await _setAsHomeAndLock();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _setAsHome() async {
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    home = await Wallpaper.homeScreen(widget.imgUrl);
    final result = home = home;
    print(result);
    Fluttertoast.showToast(
        msg: "Wallpaper is set for Homescreen",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.lightGreen[100],
        fontSize: 14.0);
  }

  _setAsLock() async {
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    home = await Wallpaper.lockScreen(widget.imgUrl);
    final result = home = lock;
    print(result);
    Fluttertoast.showToast(
        msg: "Wallpaper is set for Lockscreen",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.lightGreen[100],
        fontSize: 14.0);
  }

  _setAsHomeAndLock() async {
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    home = await Wallpaper.bothScreen(widget.imgUrl);
    final result = home = both;
    print(result);
    Fluttertoast.showToast(
        msg: "Wallpaper is set for Homescreen & Lockscreen",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.lightGreen[100],
        fontSize: 14.0);
  }
}
