import 'package:AUIS_classroom/screens/login.dart';
import 'package:AUIS_classroom/services/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'services/user.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final textTheme = Theme.of(context).textTheme;
    return ChangeNotifierProvider(
      create: (context) => User(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: KBlue,
          ),
          textTheme: GoogleFonts.merriweatherTextTheme(textTheme).copyWith(
            bodyText1:
                GoogleFonts.playfairDisplay(textStyle: textTheme.bodyText1).copyWith(
              color: Colors.black,
            ),
            headline1: GoogleFonts.sourceSansPro(textStyle: textTheme.bodyText1)
                .copyWith(
              color: Colors.black,
            ),
            bodyText2: GoogleFonts.sourceSansPro(textStyle: textTheme.bodyText1)
                .copyWith(
              color: Colors.black,
            ),
            button: GoogleFonts.merriweather(textStyle: textTheme.bodyText1).copyWith(
              color: Colors.black,
            ),
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
        initialRoute: Login.id,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
