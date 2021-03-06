import 'package:flutter/material.dart';

// colors
// const KPrimaryColor = Color(0xFF191835);
// const KSecondaryColor = Color(0xff62608F);
// const KBlue = Color(0xff4DB1FF);
// const KYellow = Color(0xffff9e00);
// const KGreen = Color(0xff00be65);

// const KPrimaryColor = Color(0xFF263145);

// const KPrimaryColor = Color(0xFF08080c);
// const KSecondaryColor = Color(0xff737474);
// const KBlue = Color(0xffffe672e);
// const KYellow = Color(0xffff9e00);
// const KGreen = Color(0xff00be65);

const KPrimaryColor = Color(0xffffffff);
const KSecondaryColor = Color(0xffaaaaaa);
const KBlue = Color(0xffd12b7b);
const KYellow = Color(0xffff9e00);
const KGreen = Color(0xff00be65);

// text style
const KPillTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.white,
  decoration: TextDecoration.none,
);
const KBox = BoxDecoration(
    color: KPrimaryColor,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: kShadow);

InputDecoration kdecorateInput(
    {@required String hint, Widget leadingIcon, Widget suffix}) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: KBlue),
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

const kShadow = [
  BoxShadow(color: Colors.black26, offset: Offset(2.0, 4.0), blurRadius: 10),
];
