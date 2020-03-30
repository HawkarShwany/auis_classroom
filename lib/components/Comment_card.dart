import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class Comment extends StatelessWidget {
  final name;
  final text;
  Comment(this.name, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:30, vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name+" :",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
