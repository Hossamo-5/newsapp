import 'package:flutter/material.dart';
import 'package:newsapp/services/apis.dart';
import 'package:newsapp/services/fun.dart';
import 'package:newsapp/view/widgets/categoriesbutton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: MediaQuery.of(context).size.height / 14),
            child: Text(
              "Choose News Categories",
              style: TextStyle(
                color: textColor,
                fontSize: fontXLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 14,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoriesButton(
                  colorButton: blue,
                  textCategories: "General",
                ),
                CategoriesButton(
                  colorButton: white,
                  textCategories: "entertainment",
                ),
                CategoriesButton(
                  colorButton: green,
                  textCategories: "Science",
                ),
                CategoriesButton(
                  colorButton: orangeLight,
                  textCategories: "Health",
                ),
                CategoriesButton(
                  colorButton: yellow,
                  textCategories: "Business",
                ),
                CategoriesButton(
                  colorButton: green,
                  textCategories: "Technology",
                ),
                CategoriesButton(
                  colorButton: orangeDark,
                  textCategories: "Sport",
                ),
                // CategoriesButton(
                //   colorButton: blue,
                //   textCategories: "General",
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Best News",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: textColor,
                fontSize: fontTitle,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: APIS.fetchArticles(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Fun.openLink(snapshot.data[index].url);
                        },
                        child: Card(
                          color: white,
                          elevation: 5,
                          shadowColor: textColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage((snapshot
                                                    .data[index].urlToImage ==
                                                null)
                                            ? "https://webhostingmedia.net/wp-content/uploads/2018/01/http-error-404-not-found.png"
                                            : "${snapshot.data[index].urlToImage}"))),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Text(
                                  "${snapshot.data[index].title}",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Fun.shareLink(
                                              snapshot.data[index].url);
                                        },
                                        icon: Icon(Icons.share)),
                                    IconButton(
                                        onPressed: () {
                                          Fun.copyLink(snapshot.data[index].url)
                                              .then((value) {
                                            final snackBar = SnackBar(
                                                content: Text('Link copy...'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          });
                                        },
                                        icon: Icon(Icons.copy)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
