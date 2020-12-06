import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m_wallpaper/data/data.dart';
import 'package:m_wallpaper/model/categories_model.dart';
import 'package:m_wallpaper/model/wallpaper_model.dart';
import 'package:m_wallpaper/views/category.dart';
import 'package:m_wallpaper/views/image_view.dart';
import 'package:m_wallpaper/views/search.dart';
import 'package:m_wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //list for categories
  List<CategoriesModel> categories = new List();
  //list for wallpapers
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  //gap
  getTrendingWallpapers() async {
    var response = await http.get(
        //geting the tranding photos here
        'https://api.pexels.com/v1/curated?per_page=15',
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

  //run in first app load
  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //searchBar
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                      searchQuery: searchController.text,
                                    )));
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              //All categories List
              Container(
                height: 80,
                child: ListView.builder(
                  //categories most Left and  mostright side Gap
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categoriesName,
                      imgUrl: categories[index].imgUrl,
                    );
                  },
                ),
              ),

              // all showing wallpapers here
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;

  CategoriesTile({@required this.imgUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      categorieName: title.toLowerCase(),
                    )));
      },
      child: Container(
        //margin for gaping one Category to other
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            //categories ImageUrl
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl,
                  fit: BoxFit.cover, height: 50, width: 100),
            ),

            //categories Name
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
