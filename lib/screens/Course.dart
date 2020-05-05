import 'package:AUIS_classroom/components/Course_details.dart';
import 'package:AUIS_classroom/components/Course_files.dart';
import 'package:AUIS_classroom/components/Course_lectures.dart';
import 'package:AUIS_classroom/components/Course_reviews.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:AUIS_classroom/components/Custom_Drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class CourseScreen extends StatefulWidget {
  static const String id = '/course';
  final courseId;
  final details;
  final lectures;
  final files;
  final reviews;
  CourseScreen(
      {this.courseId, this.details, this.lectures, this.files, this.reviews});
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  bool _canBeDragged = false;
  static const double maxSlide = 150;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                child: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      leading: GestureDetector(
                        onTap: () => _toggleAnimation(),
                        child: Icon(Icons.menu),
                      ),
                      centerTitle: true,
                      title: Text(widget.courseId),
                      bottom: TabBar(
                          isScrollable: true,
                          labelColor: KBlue,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: KBlue,
                          indicatorSize: TabBarIndicatorSize.label,
                          dragStartBehavior: DragStartBehavior.start,
                          tabs: [
                            Text('Details'),
                            Text('Video Lectures'),
                            Text('Files'),
                            Text('Reviews'),
                          ]),
                    ),
                    body: Container(
                      child: TabBarView(
                        children: [
                          Details(widget.details, widget.courseId),
                          Lectures(widget.lectures, widget.courseId),
                          Files(widget.files, widget.courseId),
                          Reviews(widget.reviews, widget.courseId),
                        ],
                      ),
                    ),
                    bottomNavigationBar: CustmoBottomNavigationBar(
                      isHome: false,
                      isFav: false,
                    ),
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
