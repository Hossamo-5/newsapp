import 'package:flutter/material.dart';
import 'package:newsapp/constant.dart';
import 'package:newsapp/services/apis.dart';
import 'package:newsapp/services/fun.dart';

class CategoryScreen extends StatefulWidget {
String textCategories;

CategoryScreen(this.textCategories);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10,vertical: MediaQuery.of(context).size.height/25),
            child: TextButton.icon(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios,size: 30,color: textColor), label: Text(
              "${widget.textCategories}",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: textColor,
                fontSize: fontTitle,
                fontWeight: FontWeight.w800,
              ),
            )),
          ),
          Expanded(
              child: FutureBuilder(
                future:APIS.fetchCategoryArticles("${widget.textCategories}"),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
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
                                          image: NetworkImage(
                                              "${snapshot.data[index].urlToImage}"))),
                                  // child: Image.network("https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AARDT2T.img?h=412&w=750&m=6&q=60&o=f&l=f"),
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
                                            Fun.shareLink(snapshot.data[index].url);
                                          }, icon: Icon(Icons.share)),
                                      IconButton(
                                          onPressed: () {
                                            Fun.copyLink(snapshot.data[index].url).then(( value ){
                                              final snackBar = SnackBar(content: Text('Link copy...'));
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                            });

                                          }, icon: Icon(Icons.copy)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else
                  {

                    return Center(child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                    ));
                  }
                },
              )
          )
        ],
      ),
    );
  }
}
