import 'package:AUIS_classroom/components/Pill.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/components/Dep.dart';




class Departments extends StatelessWidget {
  Departments({this.selectDep, this.selectedDep});
  final Function selectDep;
  final Dep selectedDep;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Pill(
              isActive: selectedDep == Dep.CORE ? true : false,
              text: "Core Requirements",
              onTap: () {
                selectDep(Dep.CORE);
                // selectedDep = Dep.CORE;
              },
            ),
            Pill(
              isActive: selectedDep == Dep.IT ? true : false,
              text: "Information Technology",
              onTap: () {
                selectDep(Dep.IT);
                // selectedDep = Dep.IT;
              },
            ),
            Pill(
              isActive: selectedDep == Dep.BUS ? true : false,
              text: "Bussines",
              onTap: () {
                selectDep(Dep.BUS);
                // selectedDep = Dep.BUS;
              },
            ),
            Pill(
              isActive: selectedDep == Dep.ENGR ? true : false,
              text: "Engineering",
              onTap: () {
                selectDep(Dep.ENGR);
                // selectedDep = Dep.ENGR;
              },
            ),
            Pill(
              isActive: selectedDep == Dep.IS ? true : false,
              text: "International Studies",
              onTap: () {
                selectDep(Dep.IS);
                // selectedDep = Dep.ENGR;
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
