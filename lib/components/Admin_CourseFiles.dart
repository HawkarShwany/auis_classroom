import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'FileTile.dart';

class AdminFiles extends StatefulWidget {
  AdminFiles(this.files, this.courseId);
  final files;
  final courseId;
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<AdminFiles> {
  File file;
  List<FileTile> fileslist = [];

  void deleteFile(dynamic id) async {
    var response = await Network.deleteFile(id.toString());
    updateScreen(response);
  }

  void updateScreen(dynamic response) async {
    if (response['response'] == 'file deleted' || response['response'] == 'file uploaded') {
      var files = await Network.getFiles(widget.courseId);
      
      setState(() {
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

  void addFiles(dynamic files) {
    if (fileslist.length > 0) {
      fileslist.removeRange(0, fileslist.length - 1);
    }

    for (var i = 0; i < files['fileCount']; i++) {
      fileslist.add(
        FileTile(
          id: files['files'][i]['fileId'],
          name: files['files'][i]['name'],
          delete: deleteFile,
        ),
      );
    }
    setState(() {
      
    });
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
              itemCount: fileslist.length,
              itemBuilder: (context, index) {
                return fileslist[index];
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
              var response =await Network.addFile(file, widget.courseId);
              updateScreen(response);
            },
          ),
        ],
      ),
    );
  }
}
