import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/components/Video.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
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
  TextEditingController _controller = TextEditingController();
  int index = 0;

  void addComments(var data) {
    for (var i = 0; i < data['commentcount']; i++) {
      comments.add(Comment(
          data['comments'][i]['studentId'], data['comments'][i]['comment']));
    }
  }

  void nothing() {}
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addLectures(widget.data);
    addComments(widget.data);
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
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (index == 0) {
                        index = lectures.length - 1;
                      } else {
                        index--;
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
                      if (index == lectures.length - 1) {
                        index = 0;
                      } else {
                        index++;
                      }
                    });
                  },
                  child: Icon(
                    Icons.arrow_right,
                    size: 35,
                    color: KBlue,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
          // add a comment
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              autocorrect: false,
              controller: _controller,
              onChanged: (value) => comment = value,
              // style: TextStyle(color: Colors.white),
              decoration: kdecorateInput(
                hint: "Add a comment",
                suffix: FlatButton(
                  onPressed: () {
                    // send the comment here
                    setState(() async {
                      Network.comment(
                          Provider.of<User>(context, listen: false).id,
                          widget.courseId,
                          comment);
                      // var lectures = await Network.getCourseLecture(widget.courseId);
                      // addComments(lectures);
                      _controller.clear();
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
        ],
      ),
    );
  }
}
