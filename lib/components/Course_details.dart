import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details(this.data){
    if (data['Prerequisites'] == null) {
      data['Prerequisites'] = 'No Prerequisite';
    }
  }
  final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Text(data['CourseId']),
            Text(data['CourseName']),
            Text(data['Credits']),
            Text(data['Prerequisites']),
            Text(data['Discription']),
          ],
        ),
      ),
    );
  }
}