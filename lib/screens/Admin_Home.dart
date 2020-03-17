import 'package:AUIS_classroom/components/Departments.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/CustomBottomNavigationBar.dart';
import 'package:AUIS_classroom/components/Dep.dart';
import 'package:AUIS_classroom/components/CourseCard.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  
  static String id = '/AdminHome';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminHomeScreen> {
  Dep selectedDep = Dep.CORE;
  List<CourseCard> courses = [];
  var response;
  // var user = Provider.of<User>(context);

  void convert(dynamic data) {
    courses.removeRange(0, courses.length );
    for (int i = 0; i < data['count']; i++) {
      courses.add(CourseCard(
        courseID: data['data'][i]['CourseId'],
        courseTitle: data['data'][i]['CourseName'],
      ));
    }
  }

  @override
  void initState()  {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(Icons.menu)),
      ),
      body: Column(
        children: <Widget>[
          Consumer<User>(
            builder: (context, user, child) => Text(
              user.fname + ' '+user.lname,
              style: TextStyle(color: Colors.white),
            ),
          ),
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
      bottomNavigationBar: CustmoBottomNavigationBar(isHome: true, isFav: false,),
    );
  }
}
