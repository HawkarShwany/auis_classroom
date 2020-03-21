import 'package:AUIS_classroom/components/Video.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Admin_CommentCard.dart';

class AdminLectures extends StatefulWidget {
  final data;
  final courseId;
  AdminLectures(this.data, this.courseId);

  @override
  _LecturesState createState() => _LecturesState();
}

class _LecturesState extends State<AdminLectures> {
  List<Video> lectures = [];
  List<AdminComment> comments = [];
  String comment;
  TextEditingController _controller = TextEditingController();
  int index;

  void deleteComment(dynamic commentId) {
    Network.deleteComment(commentId);
  }

  void deleteVideo(dynamic id) {
    Network.deleteVideo(id);
  }

  void addComments(var data) {
    for (var i = 0; i < data['commentcount']; i++) {
      comments.add(
        AdminComment(
          data['comments'][i]['studentId'],
          data['comments'][i]['comment'],
          data['comments'][i]['commentId'],
          deleteComment,
        ),
      );
    }
  }

  void addLectures(var data) {
    for (var i = 0; i < data['vidcount']; i++) {
      lectures.add(
        Video(
          data['videos'][i]['path'],
          data['videos'][i]['id'],
        ),
      );
    }
  }

  Alert addVideo() {
    String title;
    String url;

    return Alert(
      context: context,
      style: AlertStyle(
        titleStyle: TextStyle(color: Colors.white),
        backgroundColor: KSecondaryColor,
      ),
      // shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))) ,
      title: "Add a YouTube Video",
      content: Form(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) => title = value,
            decoration: kdecorateInput(hint: 'Title'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) => url = value,
            decoration: kdecorateInput(hint: 'Link'),
          ),
        ],
      )),
      buttons: [
        DialogButton(
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Network.addYouTubeVideo(title, url, widget.courseId);
              Navigator.pop(context);
            })
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addLectures(widget.data);
    addComments(widget.data);
    index = lectures.length > 0 ? 0 : -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 30),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: IndexedStack(
                index: index,
                children: lectures,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  color: KBlue,
                  onPressed: () {
                    addVideo().show();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (lectures.length > 0) {
                        if (index == 0) {
                          index = lectures.length - 1;
                        } else {
                          index--;
                        }
                      }
                    });
                  },
                  child: Icon(
                    Icons.arrow_left,
                    size: 35,
                    color: KBlue,
                  ),
                ),
                Text((index + 1).toString() + "/" + lectures.length.toString()),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (lectures.length > 0) {
                          if (index == lectures.length - 1) {
                            index = 0;
                          } else {
                            index++;
                          }
                        }
                      });
                    },
                    child: Icon(
                      Icons.arrow_right,
                      size: 35,
                      color: KBlue,
                    )),
                RaisedButton(
                  onPressed: () {
                    deleteVideo(lectures[index].getId);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white),
              ),
            ),
            child: Text(
              'comments',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return comments[index];
            },
          )),
        ],
      ),
    );
  }
}
