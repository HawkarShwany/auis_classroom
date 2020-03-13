import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';

class Pill extends StatelessWidget {
  Pill({@required this.isActive, @required this.text, this.onTap});
  final bool isActive;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          style: KPillTextStyle,
        ),
        decoration: BoxDecoration(
            color: isActive ? KBlue : KSecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
