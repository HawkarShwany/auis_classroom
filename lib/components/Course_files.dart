import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

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

  void sort(){
    setState(() {
      filesList.sort((b,a)=> a.score.toString().compareTo(b.score.toString()));
    });
    
  }

  void addFiles(dynamic files) {
    filesList.removeRange(0, filesList.length);
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
    setState(() {});
  }

  void upvote(dynamic fileId) async {
    var response = await Network.upVote(fileId, Provider.of<User>(context,listen: false).id);
    updateScreen(response);
  }

  void downvote(dynamic fileId) async{
    var response = await Network.downVote(fileId, Provider.of<User>(context,listen: false).id);
    updateScreen(response);
  }

  void updateScreen(dynamic response) async {
    if (response['response'] == 'file uploaded'|| response['response'] == 'voted') {
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ListTile(
              onTap: (){
                sort();
              },
              leading: Icon(Icons.sort, color: KYellow,),
              title: Text("Sort", style: TextStyle(color: Colors.white),),
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
