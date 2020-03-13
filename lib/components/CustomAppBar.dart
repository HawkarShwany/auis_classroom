import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      color: KPrimaryColor,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.menu,
              color: KSecondaryColor,
            ),
            onTap: (){
              Scaffold.of(context).openDrawer();
            },
          ),
          Icon(
            Icons.search,
            color: KSecondaryColor,
          ),
        ],
      ),
    );
  }
}

