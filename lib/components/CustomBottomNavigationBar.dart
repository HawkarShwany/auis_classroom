import 'package:AUIS_classroom/screens/FavoriteScreen.dart';
import 'package:AUIS_classroom/screens/Home.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';

class CustmoBottomNavigationBar extends StatelessWidget {
  CustmoBottomNavigationBar({@required this.isHome, @required this.isFav}) {
    if (isHome) {
      homeIconColor = KBlue;
      favIconColor = KSecondaryColor;
    } else if (isFav) {
      homeIconColor = KSecondaryColor;
      favIconColor = KBlue;
    } else {
      homeIconColor = KSecondaryColor;
      favIconColor = KSecondaryColor;
    }
  }
  final bool isHome;
  final bool isFav;
  Color homeIconColor;
  Color favIconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Icon(Icons.home, color: homeIconColor),
          ),
          FlatButton(
            onPressed: ()async {
              var response = await Network.getFav(Provider.of<User>(context, listen: false).id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteCourseScreen(response),
                ),
              );
            },
            child: Icon(
              Icons.favorite,
              color: favIconColor,
            ),
          ),
        ],
      ),
    );
  }
}
