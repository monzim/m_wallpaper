import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;

  ImageView({@required this.imageUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
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
                //for closeing the showing wallpaper
                GestureDetector(
                  onTap: () {},
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
                                // white54
                                color: Colors.orange[50],
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                // Color(0x36FFFFFF),
                                // Color(0x0FFFFFFF),
                                Colors.deepOrange[900],
                                Colors.blueGrey[900],
                                // Colors.amber[900]
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
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
