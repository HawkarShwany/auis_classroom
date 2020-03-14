import 'package:flutter/material.dart';
import 'package:AUIS_classroom/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/screens/Home.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static String id = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String registerEmail;
  String registerPassword;
  String registerFname;
  String registerLname;
  String registerId;
  String loginId;
  String loginPassword;

  void addUser(var data) {
    print("adding data; "+data['id']);
    Provider.of<User>(context, listen: false).setId(data['id']);
    Provider.of<User>(context, listen: false).setFname(data['fname']);
    Provider.of<User>(context, listen: false).setLname(data['lname']);
    Provider.of<User>(context, listen: false).setEmail(data['email']);
    Provider.of<User>(context, listen: false).setPassword(data['password']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
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
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: KSecondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      decoration: KEmailInput,
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
                    TextField(
                      decoration: KPasswordInput,
                      enableSuggestions: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      onChanged: (value) {
                        loginPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      child: Text(
                        "login",
                        style: KPillTextStyle,
                      ),
                      onPressed: () async {
                        var response =
                            await Network.login(loginId, loginPassword);
                        if (response['data'].toString() == 'correct') {
                          print("in login screen:"+ response['fname']);
                          addUser(response);
                          // Navigator.pushNamed(context, HomeScreen.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }else{
                          print("cant proceed");
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
                        Alert(
                          context: context,
                          title: "Register",
                          style: AlertStyle(
                              backgroundColor: KSecondaryColor,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          content: Column(
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.text,
                                decoration: KEmailInput,
                                enableSuggestions: true,
                                textAlign: TextAlign.center,
                                autofocus: false,
                                onChanged: (value) {
                                  registerId = value;
                                },
                              ),
                              TextField(
                                keyboardType: TextInputType.text,
                                decoration: KEmailInput,
                                enableSuggestions: true,
                                textAlign: TextAlign.center,
                                autofocus: false,
                                onChanged: (value) {
                                  registerFname = value;
                                },
                              ),
                              TextField(
                                keyboardType: TextInputType.text,
                                decoration: KEmailInput,
                                enableSuggestions: true,
                                textAlign: TextAlign.center,
                                autofocus: false,
                                onChanged: (value) {
                                  registerLname = value;
                                },
                              ),
                              TextField(
                                decoration: KEmailInput,
                                enableSuggestions: true,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                onChanged: (value) {
                                  registerEmail = value;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextField(
                                decoration: KPasswordInput,
                                enableSuggestions: true,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.visiblePassword,
                                autofocus: false,
                                onChanged: (value) {
                                  registerPassword = value;
                                },
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  var response = await Network.register(
                                      registerId,
                                      registerFname,
                                      registerLname,
                                      registerEmail,
                                      registerPassword);
                                  if (response == 'true') {
                                    print(response);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "register",
                                  style: KPillTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ).show();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
