import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCourseScreen extends StatefulWidget {
  static const String id = '/AddCourse';

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  TextEditingController _controller = TextEditingController();
  List<DropdownMenuItem<int>> creditItems = [
    DropdownMenuItem(
      value: 0,
      child: Text('0'),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text('1'),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text('2'),
    ),
    DropdownMenuItem(
      value: 3,
      child: Text('3'),
    ),
    DropdownMenuItem(
      value: 4,
      child: Text('4'),
    ),
  ];
  int credits = 3;

  String courseId;

  String courseTitle;

  String courseDescription;

  String prerequisites;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text("Add a new course"),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Course ID",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    enableSuggestions: true,
                    controller: _controller,
                    decoration: kdecorateInput(
                      hint: 'Course ID',
                    ),
                    onChanged: (value) => courseId = value,
                  ),
                  Text(
                    "Course Title",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    enableSuggestions: true,
                    controller: _controller,
                    decoration: kdecorateInput(
                      hint: 'Course Title',
                    ),
                    onChanged: (value) => courseTitle = value,
                  ),
                  Text(
                    "Course Description",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    // expands: true,
                    minLines: 1,
                    maxLines: 20,
                    enableSuggestions: true,
                    controller: _controller,
                    decoration: kdecorateInput(
                      hint: 'Course Description',
                    ),
                    onChanged: (value) => courseId = value,
                  ),
                  Text(
                    "Prerequisites",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    enableSuggestions: true,
                    controller: _controller,
                    decoration: kdecorateInput(
                      hint: 'Prerequisites',
                    ),
                    onChanged: (value) => prerequisites = value,
                  ),
                  Text(
                    "Credits",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  DropdownButton(
                      iconEnabledColor: Colors.white,
                      value: credits,
                      focusColor: Colors.white,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          decoration: TextDecoration.none),
                      items: creditItems,
                      onChanged: (int value) {
                        setState(() {
                          credits = value;
                        });
                      }),
                  // FloatingActionButton(onPressed: (){}),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'AddCourse',
            child: Icon(
              Icons.add,
              color: KPrimaryColor,
            ),
            onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
