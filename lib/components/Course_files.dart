import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'FileTile.dart';

class Files extends StatefulWidget {
  Files(this.files, this.courseId);
  dynamic files;
  final courseId;
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  File file;
  List<FileTile> filesList = [];

  void addFiles(dynamic files) {
    filesList.removeRange(0, filesList.length);
    for (var i = 0; i < files['fileCount']; i++) {
      filesList.add(
        FileTile(
          id: files['files'][i]['fileId'],
          name: files['files'][i]['name'],
        ),
      );
    }
    setState(() {});
  }

  void updateScreen(dynamic response) async {
    if (response['response'] == 'file uploaded') {
      var files = await Network.getFiles(widget.courseId);

      setState(() {
        widget.files = files;
        addFiles(files);
      });
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: KSecondaryColor,
        content: Text(response['response']),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addFiles(widget.files);
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
              itemCount: filesList.length,
              itemBuilder: (context, index) {
                return filesList[index];
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
              var response = await Network.addFile(file, widget.courseId);
              updateScreen(response);
            },
          ),
        ],
      ),
    );
  }
}
