import 'package:AUIS_classroom/screens/Course.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  CourseCard(
      {this.courseID,
      this.courseTitle,
      this.updateFavScreen,
      this.isFav = false});
  String courseID;
  String courseTitle;
  Function updateFavScreen;
  bool isFav;
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  Color heartIconColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heartIconColor = widget.isFav ? KBlue : KPrimaryColor;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _controller.addListener(() {});
    opacity = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    print(animation);
    setState(() {
      _controller.forward();
    });

    return FadeTransition(
      opacity: animation,
      // opacity: opacity,
      // duration: Duration(milliseconds: 600),
      child: Container(
        decoration: BoxDecoration(
          color: KSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.courseID,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.courseTitle,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      // use the courseID{}
                      var details =
                          await Network.getCourseDetail(widget.courseID);
                      var lectures =
                          await Network.getCourseLecture(widget.courseID);
                      var files = await Network.getFiles(widget.courseID);
                      var reviews = await Network.getReviews(widget.courseID);
                      Navigator.pushNamed(context, CourseScreen.id, arguments: [
                        widget.courseID,
                        details,
                        lectures,
                        files,
                        reviews
                      ]);
                    },
                    child: Text(
                      "More Details",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.favorite,
                color: heartIconColor,
              ),
              onTap: () {
                setState(() {
                  heartIconColor =
                      (heartIconColor == KPrimaryColor) ? KBlue : KPrimaryColor;
                  if (heartIconColor == KPrimaryColor) {
                    Network.unmarkFav(
                        Provider.of<User>(context, listen: false).id,
                        widget.courseID);
                    widget.updateFavScreen();
                  } else {
                    Network.markFav(
                        Provider.of<User>(context, listen: false).id,
                        widget.courseID);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
