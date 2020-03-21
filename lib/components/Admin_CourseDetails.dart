import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/Dep.dart';

class AdminDetails extends StatefulWidget {
  static const String id = '/AdminDetails';
  dynamic data;
  AdminDetails(this.data);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseId = widget.data['CourseId'];
    courseTitle = widget.data['CourseName'];
    courseDescription = widget.data['Discription'];
    department = getDep(widget.data['DepId']);
    prerequisites = widget.data['Prerequisites'] == null
        ? ''
        : widget.data['Prerequisites'];
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
            onPressed: () {
              // update the course here
              
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}