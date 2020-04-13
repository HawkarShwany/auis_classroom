import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/Dep.dart';

class AddCourseScreen extends StatefulWidget {
  static const String id = '/AddCourse';

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final globalKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
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

  String courseId = '';

  String courseTitle = '';

  String courseDescription = '';

  Dep department = Dep.CORE;

  String prerequisites = '';

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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Course ID",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return '* this feild can not be empty';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.characters,
                    enableSuggestions: true,
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return '* this feild can not be empty';
                      }
                      return null;
                    },
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
                        value: department,
                        decoration: kdecorateInput(hint: null),
                        items: departments,
                        onChanged: (dynamic value) {
                          setState(() {
                            department = value;
                          });
                        }),
                  ),
                  Text(
                    "Credits",
                    style: TextStyle(fontSize: 20, height: 3),
                  ),
                  Container(
                    width: 80,
                    child: DropdownButtonFormField(
                        value: credits,
                        decoration: kdecorateInput(hint: null),
                        items: creditItems,
                        onChanged: (int value) {
                          setState(() {
                            credits = value;
                          });
                        }),
                  ),
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
            onPressed: () async {
              if (formKey.currentState.validate()) {
                var response = await Network.addCourse(
                  courseId: courseId,
                  courseTitle: courseTitle,
                  courseDesc: courseDescription,
                  prerequisites: prerequisites,
                  department: department.toString(),
                  credits: credits,
                );

                if (response['response'] == 'added') {
                  // globalKey.currentState.showSnackBar(SnackBar(
                  //     backgroundColor: KSecondaryColor,
                  //     content: Text(response['response'])));

                  Navigator.pop(context);
                }
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
