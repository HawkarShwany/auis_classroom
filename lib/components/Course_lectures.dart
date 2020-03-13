import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/components/Video.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lectures extends StatefulWidget {
  final data;
  final courseId;
  Lectures(this.data, this.courseId);

  @override
  _LecturesState createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  List<Video> lectures = [];
  List<Comment> comments = [];
  String comment;

  void addComments() {
    for (var i = 0; i < widget.data['commentcount']; i++) {
      comments.add(Comment(widget.data['comments'][i]['studentId'],
          widget.data['comments'][i]['comment']));
    }
  }

  void addLectures() {
    for (var i = 0; i < widget.data['vidcount']; i++) {
      lectures.add(Video(widget.data['videos'][i]['path']));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addLectures();
    addComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30),
            child: AspectRatio(
              aspectRatio: 1.8,
              child: ListView.builder(
                itemCount: lectures.length,
                itemBuilder: (context, index) {
                  // if there is no lecture
                  if (lectures.length == 0) {
                    print(lectures.length);
                    return Center(
                        child: Text(
                      "No lecture available at the moment",
                      style: TextStyle(color: Colors.white),
                    ));
                  } else {
                    print(lectures.length);
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: lectures[index],
                    );
                  }
                },
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Container(
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
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextFormField(
                onChanged: (value) => comment = value,
                style: TextStyle(color: Colors.white),
                decoration: kdecorateInput(
                  hint: "Add a comment",
                  suffix: FlatButton(
                    onPressed: () {
                      // send the comment here
                      setState(() {
                        Network.comment(
                            Provider.of<User>(context, listen: false).id,
                            widget.courseId,
                            comment);
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: KBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}