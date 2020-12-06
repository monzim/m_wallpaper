import 'package:flutter/material.dart';
import 'package:m_wallpaper/model/wallpaper_model.dart';
import 'package:m_wallpaper/views/image_view.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'M', style: TextStyle(color: Colors.deepOrange[100])),
        TextSpan(text: 'Wall', style: TextStyle(color: Colors.deepOrange[100])),
        TextSpan(text: 'paper', style: TextStyle(color: Colors.white)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,

      //gap between two images
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageView(
                        imageUrl: wallpaper.src.portrait,
                      )),
            );
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Stack(
              children: [
                //corner of images
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[100],
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  height: 266,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [Text("Loading..")],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
