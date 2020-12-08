import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ImageView extends StatefulWidget {
  final String imageUrl;

  ImageView({@required this.imageUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imageUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          //the buttons is here
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //wallpaper download button
                GestureDetector(
                  onTap: () async {
                    File file = await DefaultCacheManager()
                        .getSingleFile(widget.imageUrl);
                    print(file.path);
                    final result = await ImageGallerySaver.saveFile(file.path);
                    print("gallerysaver result $result");

                    String resultWall =
                        await WallpaperManager.setWallpaperFromFile(
                            file.path, WallpaperManager.HOME_SCREEN);

                    print("resultWall $resultWall");
                  },
                  child: Stack(
                    children: [
                      Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: Color(0xff1c1b1b).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30),
                          )),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                Colors.blueGrey[100],
                                Colors.grey[900],
                              ])),
                          child: Column(
                            children: [
                              Text(
                                'Set Wallpaper',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Image wil be save in gallery',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                //for closeing the showing wallpaper
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(height: 50)
              ],
            ),
          )
        ],
      ),
    );
  }
}
