import 'package:AUIS_classroom/screens/Home.dart';
import 'package:AUIS_classroom/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'services/user.dart';
import 'package:AUIS_classroom/screens/Course.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider(
      create: (context) => User(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white,),
            bodyText2: TextStyle(color: Colors.white,),
            button: TextStyle(color: Colors.white),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: KBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),
          primaryColor: KPrimaryColor,
          backgroundColor: KPrimaryColor,
          scaffoldBackgroundColor: KPrimaryColor,
        ),
        home: Login(),
        // routes: {
        //   HomeScreen.id: (context) => HomeScreen(),
        //   Login.id: (context) => Login(),
        //   CourseScreen.id: (context) => CourseScreen(),
        // },
      ),
    );
  }
}
