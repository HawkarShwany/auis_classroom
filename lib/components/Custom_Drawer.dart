import 'package:AUIS_classroom/screens/login.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<User>(context).fname +
        ' ' +
        Provider.of<User>(context).lname;
    return Scaffold(
      body: Container(
        color: KSecondaryColor,
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
                GoogleSignIn _googleSignIn = GoogleSignIn();
                _googleSignIn.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, Login.id, (route) => false);
              },
              leading: Icon(
                Icons.exit_to_app,
                color: KBlue,
              ),
              title: Text('Log out', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
