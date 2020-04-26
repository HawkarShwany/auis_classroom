import 'package:AUIS_classroom/components/Admin_CourseCard.dart';
import 'package:AUIS_classroom/components/Custom_Drawer.dart';
import 'package:AUIS_classroom/components/Departments.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/screens/Admin_AddCourse.dart';
import 'package:AUIS_classroom/screens/Search.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/Dep.dart';

class AdminHomeScreen extends StatefulWidget {
  static const String id = '/AdminHome';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool _canBeDragged = false;
  static const double maxSlide = 150;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;

  Dep selectedDep = Dep.CORE;
  List<AdminCourseCard> courses = [];
  var response;
  // var user = Provider.of<User>(context);

  void convert(dynamic data) {
    courses.removeRange(0, courses.length);
    for (int i = 0; i < data['count']; i++) {
      courses.add(AdminCourseCard(
        courseID: data['data'][i]['CourseId'],
        courseTitle: data['data'][i]['CourseName'],
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectDep(selectedDep);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// I got these functions from here
// source: https://github.com/MarcinusX/drawer_challenge/blob/master/lib/custom_drawer.dart
  void close() => _controller.reverse();
  void open() => _controller.forward();

  void _toggleAnimation() => _controller.isCompleted ? close() : open();

  void _ondragstart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        _controller.isDismissed && details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight =
        _controller.isCompleted && details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _ondragupdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _controller.value += delta;
    }
  }

  void _ondragend(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_controller.isDismissed || _controller.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _controller.fling(velocity: visualVelocity);
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  void selectDep(Dep dep) async {
    response = await Network.getCourses(dep);
    convert(response);
    setState(() {
      selectedDep = dep;
    });
  }

  void search() async {
    final searchWord = await Navigator.pushNamed(context, SearchScreen.id);

    var searchResult = await Network.searchCourse(searchWord.toString());
    print(searchResult);
    setState(() {
      selectedDep = null;
      convert(searchResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _ondragstart,
      onHorizontalDragUpdate: _ondragupdate,
      onHorizontalDragEnd: _ondragend,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          var scale = 1 - (_controller.value * 0.3);
          final slideAmount = maxSlide * _controller.value;
          return Stack(
            children: <Widget>[
              CustomDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slideAmount)
                  ..scale(scale),
                alignment: Alignment.center,
                child: Scaffold(
                  appBar: AppBar(
                    leading: GestureDetector(
                      onTap: () => _toggleAnimation(),
                      child: Icon(Icons.menu),
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            search();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  body: Column(
                    children: <Widget>[
                      Departments(
                        selectDep: selectDep,
                        selectedDep: selectedDep,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return courses[index];
                          },
                          itemCount: courses.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    heroTag: 'AddCourse',
                    child: Icon(
                      Icons.add,
                      color: KPrimaryColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddCourseScreen.id);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
