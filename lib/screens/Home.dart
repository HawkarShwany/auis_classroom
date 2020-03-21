import 'package:AUIS_classroom/components/Custom_Drawer.dart';
import 'package:AUIS_classroom/components/Departments.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:AUIS_classroom/components/Dep.dart';
import 'package:AUIS_classroom/components/CourseCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dep selectedDep = Dep.CORE;
  List<CourseCard> courses = [];
  var response;
  bool searchIsVisible = false;
  // var user = Provider.of<User>(context);

  void convert(dynamic data) {
    courses.removeRange(0, courses.length);
    for (int i = 0; i < data['count']; i++) {
      courses.add(CourseCard(
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
  }

  void selectDep(Dep dep) async {
    response = await Network.getCourses(dep);
    convert(response);
    setState(() {
      selectedDep = dep;
    });
  }

  Widget title() {
    if (!searchIsVisible) {
      return Text('');
    } else {
      return TextFormField(
        decoration: kdecorateInput(hint: "Search by ID"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 10,
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: title(),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                if (searchIsVisible) {
                  searchIsVisible = false;
                  // search for a course here
                  print("searchin.......");
                } else {
                  searchIsVisible = true;
                }
              });
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
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
      bottomNavigationBar: CustmoBottomNavigationBar(
        isHome: true,
        isFav: false,
      ),
    );
  }
}
