import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m_wallpaper/data/data.dart';
import 'package:m_wallpaper/model/wallpaper_model.dart';
import 'package:m_wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  getSearchgWallpapers(String query) async {
    var response = await http.get(
        //geting the tranding photos here
        "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {"Authorization": apiKey});

    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);

      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchgWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xfff5f8fd)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    //searchBar
                    InkWell(
                      onTap: () {
                        getSearchgWallpapers(searchController.text);
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              // all Searching showing wallpapers here
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
