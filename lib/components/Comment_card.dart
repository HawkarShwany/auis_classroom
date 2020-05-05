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
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: kShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name+" :",
            style: TextStyle( fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              text,
            ),
          )
        ],
      ),
    );
  }
}
