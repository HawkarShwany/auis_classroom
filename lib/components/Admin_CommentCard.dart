import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class AdminComment extends StatelessWidget {
  final name;
  final text;
  final commentId;
  Function deleteComment;
  AdminComment(this.name, this.text, this.commentId, this.deleteComment);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: kShadow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name + ":",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              deleteComment(commentId);
            },
            child: Icon(
              Icons.delete_forever,
              color: KSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
