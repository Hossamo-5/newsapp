import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/view/screens/categoriescreen.dart';
class CategoriesButton extends StatelessWidget {
  String textCategories;
  Color colorButton;
  CategoriesButton({ required this.textCategories,required this.colorButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5,vertical: 2.5),
      child: RaisedButton(onPressed: () {
        Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) {
return CategoryScreen(textCategories);
        }));
      },
        color: colorButton,
        child: Text("$textCategories"),
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ) ,
      ),
    );
  }
}
