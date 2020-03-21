import 'package:AUIS_classroom/screens/login.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<User>(context).fname +
        ' ' +
        Provider.of<User>(context).lname;
    return Container(
      color: KPrimaryColor,
      child: ListView(
        children: <Widget>[
          Center(
            child: DrawerHeader(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          // Divider(height: 1, color: Colors.white,),
          ListTile(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, Login.id,  (route) => false);
            },
            leading: Icon(
              Icons.exit_to_app,
              color: KYellow,
            ),
            title: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
