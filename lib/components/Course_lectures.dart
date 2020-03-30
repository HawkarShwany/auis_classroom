import 'package:AUIS_classroom/components/Comment_card.dart';
import 'package:AUIS_classroom/components/Video.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lectures extends StatefulWidget {
  final courseId;
  Lectures(this.courseId);

  @override
  _LecturesState createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  List<Video> lectures = [];
  List<Comment> comments = [];
  String comment;
  TextEditingController _controller = TextEditingController();
  int index;

  void addComments(var data) {
    comments.removeRange(0, comments.length);
    for (var i = 0; i < data['commentcount']; i++) {
      comments.add(Comment(
          data['comments'][i]['fname'] + ' ' + data['comments'][i]['lname'],
          data['comments'][i]['comment']));
    }
  }

  void addLectures(var data) {
    lectures.removeRange(0, lectures.length);
    for (var i = 0; i < data['vidcount']; i++) {
      lectures.add(
        Video(
          data['videos'][i]['path'],
          data['videos'][i]['id'],
        ),
      );
    }
  }

  void updateScreen(dynamic response) async {
    if (response['response'] == 'added') {
      var lectures = await Network.getCourseLecture(widget.courseId);
      setState(() {
        addComments(lectures);
        addLectures(lectures);
      });
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: KSecondaryColor,
        content: Text(response['response']),
      ),
    );
  }

  Widget addLecture() {
    if (lectures.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Text("No Lectures available now"),
      );
    } else {
      return Column(
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
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget commentHeader() {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: Network.getCourseLecture(widget.courseId),
        builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        addLectures(snapshot.data);
        addComments(snapshot.data);
        index = lectures.length > 0 ? 0 : -1;
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              children: <Widget>[
                addLecture(),
                commentHeader(),
                Expanded(
                    child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    if (comments.length == 0)
                      return CircularProgressIndicator();
                    return comments[index];
                  },
                )),
                // add a comment
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
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
                            var response = await Network.comment(
                                Provider.of<User>(context, listen: false).id,
                                widget.courseId,
                                comment);
                            updateScreen(response);

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
          ),
        );
      }),
    );
  }
}
