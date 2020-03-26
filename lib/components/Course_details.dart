import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details(this.data) {
    if (data['PrerequisiteCourseId'] == null) {
      data['PrerequisiteCourseId'] = 'No Prerequisite';
    }
  }
  final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              data['CourseId'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            Text(data['CourseName'], style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text("Number of credits: "+data['Credits'],style: TextStyle(fontSize: 14),),
            SizedBox(height: 10,),
            Text("Prerequisites: "+data['PrerequisiteCourseId'], style: TextStyle(fontSize: 14),),
            SizedBox(height: 20,),
            Text("Description",style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text(data['Discription'], style: TextStyle(height: 1.5),),
          ],
        ),
      ),
    );
  }
}
