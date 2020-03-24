import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final id;
  final name;
  Function delete;
  FileTile({@required this.id, @required this.name, this.delete});

  Widget deleteIcon() {
    if (delete == null) {
      return Container();
    } else {
      return GestureDetector(
          onTap:(){
            delete(id);
          } ,
          child: Icon(
            Icons.delete_forever,
            color: KPrimaryColor,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
          deleteIcon(),
        ],
      ),
    );
  }
}
