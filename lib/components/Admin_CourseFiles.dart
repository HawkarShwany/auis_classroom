import 'dart:convert';
import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'FileTile.dart';

// import 'dart:html' as html;
import 'dart:async';

class AdminFiles extends StatefulWidget {
  AdminFiles(this.data, this.courseId);
  final courseId;
  final data;
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
    if (response['response'] == 'file deleted' ||
        response['response'] == 'file uploaded') {
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
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addFiles(widget.data);
  }

  // Future<String> getFile() {
  // final completer = new Completer<String>();
  // final html.InputElement input = html.document.createElement('input');
  // input
  //     ..type = 'file'
  //     ..accept = 'image/*';
  // input.onChange.listen((e) async {
  //   final List<html.File> files = input.files;
  //   final reader = new html.FileReader();
  //   reader.readAsDataUrl(files[0]);
  //   reader.onError.listen((error) => completer.completeError(error));
  //   await reader.onLoad.first;
  //   completer.complete(reader.result as String);
  // });
  // input.click();
  // print(completer.future.toString());
  // return completer.future;
// }

  void openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  String getPrefix(String filetype) {
    switch (filetype) {
      case 'ppt':
        return 'data:application/vnd.ms-powerpoint;base64,';
      case 'pdf':
        return 'data:application/pdf;base64,';
      case 'jpg':
        return 'data:image/jpeg;base64,';
      case 'pptx':
        return 'data:application/vnd.openxmlformats-officedocument.presentationml.presentation;base64,';
      case 'docx':
        return 'data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,';
      default:
        return 'uknown,';
    }
  }

  void upload() async {
    if (kIsWeb) {
      String url = 'http://192.168.1.9:8081/capstone/web/upload.php?courseId=' +
          widget.courseId;
      openUrl(url);
    } else {
      file = await FilePicker.getFile();
      print("print file" + file.toString());
      String filename = file.path.split('/').last;
      String filetype = filename.split('.').last;
      String fileString =
          getPrefix(filetype) + base64Encode(file.readAsBytesSync());

      var response = await Network.addFile(
          fileString: fileString,
          filename: filename,
          fileType: filetype,
          courseId: widget.courseId);
      updateScreen(response);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              upload();
            },
          ),
        ],
      ),
    );
  }
}
