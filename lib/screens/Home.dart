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

import 'Search.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dep selectedDep = Dep.CORE;
  List<CourseCard> courses = [];
  var response;
  
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
    return Scaffold(
      drawer: Drawer(
        elevation: 10,
        child: CustomDrawer(),
      ),
      appBar: AppBar(
       
        automaticallyImplyLeading: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              search();
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
                if (courses.length == 0) 
                  return CircularProgressIndicator();
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
