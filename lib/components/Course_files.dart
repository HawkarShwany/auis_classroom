import 'dart:convert';
import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'FileTile.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;

class Files extends StatefulWidget {
  Files(this.data, this.courseId);
  final data;
  final courseId;
  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  File file;
  List<FileTile> filesList = [];

  void sort() {
    setState(() {
      filesList
          .sort((b, a) => a.score.toString().compareTo(b.score.toString()));
    });
  }

  void addFiles(dynamic files) {
    if (filesList.isNotEmpty) {
      filesList.removeRange(0, filesList.length);
    }

    for (var i = 0; i < files['fileCount']; i++) {
      filesList.add(
        FileTile(
          id: files['files'][i]['fileId'],
          name: files['files'][i]['name'],
          score: files['files'][i]['score'],
          upvote: upvote,
          downvote: downvote,
        ),
      );
    }
  }

  void upvote(dynamic fileId) async {
    var response = await Network.upVote(
        fileId, Provider.of<User>(context, listen: false).id);
    updateScreen(response);
  }

  void downvote(dynamic fileId) async {
    var response = await Network.downVote(
        fileId, Provider.of<User>(context, listen: false).id);
    updateScreen(response);
  }

  void updateScreen(dynamic response) async {
    if (response['response'] == 'file uploaded' ||
        response['response'] == 'voted') {
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

  void openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void upload() async {
    if (kIsWeb) {
      String url = 'http://192.168.1.9:8081/capstone/web/upload.php?courseId=' +
          widget.courseId;
      openUrl(url);
    } else {
      file = await FilePicker.getFile();
    }
    String filename = file.path.split('/').last;
    String filetype = filename.split('.').last;
    String fileString =
        getPrefix(filetype) + base64Encode(file.readAsBytesSync());

    var response = await Network.addFile(
      fileString: fileString,
      fileType: filetype,
      filename: filename,
      courseId: widget.courseId,
    );
    updateScreen(response);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addFiles(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ListTile(
              onTap: () {
                sort();
              },
              leading: Icon(
                Icons.sort,
                color: KYellow,
              ),
              title: Text(
                "Sort",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
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
              upload();
            },
          ),
        ],
      ),
    );
  }
}
