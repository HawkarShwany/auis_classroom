import 'package:AUIS_classroom/screens/Course.dart';
import 'package:AUIS_classroom/services/network.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  CourseCard({this.courseID, this.courseTitle, this.isFav = false});
  String courseID;
  String courseTitle;
  bool isFav;
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  Color heartIconColor ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    heartIconColor = widget.isFav ? KBlue: 
  KPrimaryColor;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  height: 10,
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
                    // use the courseID
                    String courseId = widget.courseID;
                    var details = await Network.getCourseDetail(courseId);
                    var lectures = await Network.getCourseLecture(courseId);
                    var reviews = await Network.getReviews(courseId);
                    // Navigator.pushNamed(context, CourseScreen.id, arguments: CourseScreen(response));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseScreen(
                          details: details,
                          lectures: lectures,
                          // files: ,
                          reviews: reviews,
                        ),
                      ),
                    );
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
                heartIconColor = (heartIconColor == KPrimaryColor)
                    ? KBlue
                    : KPrimaryColor;
                    if (heartIconColor == KPrimaryColor) {
                      Network.unmarkFav(Provider.of<User>(context, listen: false).id ,widget.courseID);
                    }else{
                      Network.markFav(Provider.of<User>(context, listen: false).id ,widget.courseID);
                    }
              });
            },
          ),
        ],
      ),
    );
  }
}