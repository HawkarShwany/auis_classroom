import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';

class Files extends StatefulWidget {
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: ListView(),),
          FloatingActionButton(
            child: Icon(Icons.file_upload, color: KPrimaryColor,),
            onPressed: () {
              
            },
          ),
        ],
      ),
    );
  }
}