import 'package:AUIS_classroom/screens/Admin_Home.dart';
import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/screens/Home.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static const String id = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginformKey = GlobalKey<FormState>();
  final _registerformKey = GlobalKey<FormState>();
  final _adminformKey = GlobalKey<FormState>();
  String registerEmail;
  String registerPassword;
  String registerFname;
  String registerLname;
  String registerId;
  String loginId;
  String loginPassword;
  String adminemail;
  String adminPassword;
  bool _isVisible = false;
  bool _adminIncorrectIsvisible = false;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication auth = await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      String fname = user.displayName.split(' ').first;
      String lname = user.displayName.split(' ').last;
      String id = user.uid;
      String email = user.email;
      String password = 'none';
      var response = await Network.register(id, fname, lname, email, password);
      if (response['registered'] == 'true' ||
          response['registered'] == 'duplicate') {
        login(id, password);
      }
    } catch (error) {
      print("error: " + error.toString());
    }
  }

  void addUser(var data) {
    print("adding data; " + data['id']);
    Provider.of<User>(context, listen: false).setId(data['id']);
    Provider.of<User>(context, listen: false).setFname(data['fname']);
    Provider.of<User>(context, listen: false).setLname(data['lname']);
    Provider.of<User>(context, listen: false).setEmail(data['email']);
    Provider.of<User>(context, listen: false).setPassword(data['password']);
    Provider.of<User>(context, listen: false).admin(data['isAdmin']);
  }

  void login(String id, String password) async {
    var response = await Network.login(id, password);
    print(response);
    if (response['data'].toString() == 'correct') {
      addUser(response);
      // Navigator.pushNamed(context, HomeScreen.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        _isVisible = true;
      });

      print("cant proceed");
    }
  }

  void adminLogin() async {
    var response = await Network.adminLogin(adminemail, adminPassword);
    if (response['data'].toString() == 'correct') {
      addUser(response);
      // navigate
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
      );
    } else {
      setState(() {
        _adminIncorrectIsvisible = true;
      });
      print("cant proceed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    "AUIS Classroom",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),

                // the box of inputs
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: KSecondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Form(
                    key: _loginformKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return '* Please enter text here';
                            }
                            return null;
                          },
                          decoration: kdecorateInput(hint: 'ID'),
                          enableSuggestions: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          onChanged: (value) {
                            loginId = value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '* Please enter text here';
                            }
                            return null;
                          },
                          decoration: kdecorateInput(hint: 'Password'),
                          enableSuggestions: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.visiblePassword,
                          autofocus: false,
                          onChanged: (value) {
                            loginPassword = value;
                          },
                        ),
                        Visibility(
                            visible: _isVisible,
                            child: Text(
                              "ID or password is incorrect",
                              style: TextStyle(color: Colors.red),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RaisedButton(
                              child: Text(
                                "login",
                                style: KPillTextStyle,
                              ),
                              onPressed: () async {
                                if (_loginformKey.currentState.validate()) {
                                  login(loginId, loginPassword);
                                }
                              },
                            ),
                            Text(
                              'or',
                              style: TextStyle(color: Colors.white),
                            ),
                            RaisedButton(
                              child: Text(
                                "register",
                                style: KPillTextStyle,
                              ),
                              onPressed: () {
                                register();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GoogleSignInButton(
                          onPressed: () {
                            _handleSignIn();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Text('Admins'),
                FlatButton(
                  onPressed: () {
                    adminLoginPopup();
                  },
                  child: Text(
                    'login here',
                    style: TextStyle(color: KBlue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void adminLoginPopup() {
    // setState(() {
    //   _adminIncorrectIsvisible = false;
    // });

    Alert(
        context: context,
        title: 'Admin Login',
        style: AlertStyle(
          backgroundColor: KSecondaryColor,
          titleStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        content: Form(
          key: _adminformKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Please enter text here';
                  }
                  return null;
                },
                decoration: kdecorateInput(hint: 'Email'),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                onChanged: (value) {
                  adminemail = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Please enter text here';
                  }
                  return null;
                },
                decoration: kdecorateInput(hint: 'Password'),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                autofocus: false,
                onChanged: (value) {
                  adminPassword = value;
                },
              ),
              Visibility(
                  visible: _adminIncorrectIsvisible,
                  child: Text(
                    "ID or password is incorrect",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )),
            ],
          ),
        ),
        buttons: [
          DialogButton(
              child: Text(
                "login",
                // style: KPillTextStyle,
              ),
              onPressed: () {
                if (_adminformKey.currentState.validate()) {
                  adminLogin();
                }
              }),
        ]).show();
  }

  void register() {
    Alert(
        context: context,
        title: "Register",
        style: AlertStyle(
            backgroundColor: KSecondaryColor,
            titleStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
        content: Form(
          key: _registerformKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              // id
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: kdecorateInput(hint: 'ID'),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                autofocus: false,
                onChanged: (value) {
                  registerId = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              // first name
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: kdecorateInput(hint: 'First Name'),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                autofocus: false,
                onChanged: (value) {
                  registerFname = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              // last name
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: kdecorateInput(hint: 'Last Name'),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                autofocus: false,
                onChanged: (value) {
                  registerLname = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              // email
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  }
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  // if (!regex.hasMatch(value))
                  //   return 'Enter Valid Email';

                  return null;
                },
                decoration: kdecorateInput(hint: "Email"),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                onChanged: (value) {
                  registerEmail = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              // password
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '* Required';
                  } else if (value.length < 6) {
                    return 'Password must be more than 5 charachters';
                  }
                  return null;
                },
                decoration: kdecorateInput(hint: 'Password'),
                enableSuggestions: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                autofocus: false,
                onChanged: (value) {
                  registerPassword = value;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: KBlue,
            radius: BorderRadius.all(Radius.circular(10)),
            child: Text(
              "register",
              style: KPillTextStyle,
            ),
            onPressed: () async {
              if (_registerformKey.currentState.validate()) {
                var response = await Network.register(registerId, registerFname,
                    registerLname, registerEmail, registerPassword);
                print(response.toString());
                if (response == 'true') {
                  print(response);
                  Navigator.pop(context);
                }
              }
            },
          )
        ]).show();
  } // register
}
