import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/Dep.dart';

class AdminDetails extends StatefulWidget {
  static const String id = '/AdminDetails';
  final courseId;
  final data;
  AdminDetails(this.data, this.courseId);

  @override
  _AdminDetailsState createState() => _AdminDetailsState();
}

class _AdminDetailsState extends State<AdminDetails> {
  List<DropdownMenuItem<Dep>> departments = [
    DropdownMenuItem(
      value: Dep.CORE,
      child: Text('Core Requirements'),
    ),
    DropdownMenuItem(
      value: Dep.BUS,
      child: Text('Bussiness'),
    ),
    DropdownMenuItem(
      value: Dep.IT,
      child: Text('Information Technology'),
    ),
    DropdownMenuItem(
      value: Dep.ENGR,
      child: Text('Engineering'),
    ),
    DropdownMenuItem(
      value: Dep.IS,
      child: Text('International Studies'),
    ),
  ];
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
  String originalCourseId;

  String courseTitle;

  String courseDescription;

  Dep department;

  String prerequisites;

  Dep getDep(dynamic dep) {
    switch (dep) {
      case '2':
        return Dep.CORE;
      case '3':
        return Dep.BUS;
      case '1':
        return Dep.IT;
      case '4':
        return Dep.ENGR;
      case '5':
        return Dep.IS;
      default:
        return null;
    }
  }

  void updateScreen(dynamic response) async {
    if (response['response'] == 'updated') {
      var newData = await Network.getCourseDetail(courseId);
      setState(() {
        courseId = newData['CourseId'];
        courseTitle = newData['CourseName'];
        courseDescription = newData['Discription'];
        department = getDep(newData['DepId']);
        prerequisites = newData['PrerequisiteCourseId'] == null
            ? ''
            : newData['PrerequisiteCourseId'];
      });
    }
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: KSecondaryColor, content: Text(response['response'])));
  }

  void deleteCourse() async {
    var response = await Network.deleteCourse(originalCourseId);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response['response'],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    if (response['response'] == 'deleted') {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseId = widget.data['CourseId'];
    originalCourseId = widget.data['CourseId'];
    courseTitle = widget.data['CourseName'];
    courseDescription = widget.data['Discription'];
    department = getDep(widget.data['DepId']);
    prerequisites = widget.data['PrerequisiteCourseId'] == null
        ? ''
        : widget.data['PrerequisiteCourseId'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                        child: Text(
                          'Delete this course',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          deleteCourse();
                        }),
                  ),
                  Text(
                    "Course ID",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    enableSuggestions: true,
                    initialValue: courseId,
                    // controller: _controller,
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
                    initialValue: courseTitle,
                    enableSuggestions: true,
                    // controller: _controller,
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
                    initialValue: courseDescription,
                    // expands: true,
                    minLines: 1,
                    maxLines: 20,
                    enableSuggestions: true,
                    // controller: _controller,
                    decoration: kdecorateInput(
                      hint: 'Course Description',
                    ),
                    onChanged: (value) => courseDescription = value,
                  ),
                  Text(
                    "Prerequisites",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    initialValue: prerequisites,
                    enableSuggestions: true,
                    // controller: _controller,
                    decoration: kdecorateInput(
                      hint: 'Prerequisites',
                    ),
                    onChanged: (value) => prerequisites = value,
                  ),
                  Text(
                    "Department",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  Container(
                    width: 250,
                    child: DropdownButtonFormField(
                      decoration: kdecorateInput(hint: null),
                      value: department,
                      items: departments,
                      onChanged: (dynamic value) {
                        setState(() {
                          department = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Credits",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  Container(
                    width: 80,
                    child: DropdownButtonFormField(
                      value: credits,
                      decoration: kdecorateInput(hint: null).copyWith(),
                      items: creditItems,
                      onChanged: (int value) {
                        setState(() {
                          credits = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            heroTag: 'AddCourse',
            child: Icon(
              Icons.done,
              color: KPrimaryColor,
            ),
            onPressed: () async {
              // update the course here
              var response = await Network.updateCourse(
                  originalCourseId: originalCourseId,
                  newCourseId: courseId,
                  courseTitle: courseTitle,
                  courseDesc: courseDescription,
                  prerequisites: prerequisites,
                  department: department.toString(),
                  credits: credits);
              updateScreen(response);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
