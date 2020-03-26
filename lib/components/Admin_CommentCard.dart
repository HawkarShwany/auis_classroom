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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
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
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              deleteComment(commentId);
            },
            child: Icon(
              Icons.delete_forever,
              color: KPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
