import 'package:flutter/material.dart';

// colors
const KPrimaryColor = Color(0xFF191835);
const KSecondaryColor = Color(0xff62608F);
const KBlue = Color(0xff4DB1FF);
const KYellow = Color(0xffff9e00);
const KGreen = Color(0xff00be65);

// text style
const KPillTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.white,
  decoration: TextDecoration.none,
);
const KBox = BoxDecoration(
  
  color: KSecondaryColor,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

InputDecoration kdecorateInput(
    {@required String hint, Widget leadingIcon, Widget suffix}) {
  return InputDecoration(
    
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      hoverColor: Colors.white,
      focusColor: Colors.white,
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      icon: leadingIcon,
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ));
}
