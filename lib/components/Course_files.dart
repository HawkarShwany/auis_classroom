import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'FileTile.dart';


class Files extends StatefulWidget {
  Files(this.files, this.courseId);
  final files;
  final courseId;
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  File file;
  List<FileTile> files=[];

  void addFiles(){
    for (var i = 0; i < widget.files['fileCount']; i++) {
      files.add(
        FileTile(id: widget.files['files'][i]['fileId'], name: widget.files['files'][i]['name'])
      );
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    addFiles();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.files);
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: files.length,
              itemBuilder: (context, index) {
                return files[index];
              },
            ),
          ),
          FloatingActionButton(
            child: Icon(
              Icons.file_upload,
              color: KPrimaryColor,
            ),
            onPressed: () async {
              file = await FilePicker.getFile();
              Network.addFile(
                file,
                widget.courseId
              );
            },
          ),
        ],
      ),
    );
  }
}

