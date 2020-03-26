import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String id = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final formKey = GlobalKey<FormState>();
  String searchWord;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: TextFormField(
            onChanged: (value){
              searchWord = value;
            },
            autocorrect: true,
            autofocus: true,
            validator: (value) {
              if (value.isEmpty) {
                return '* this feild can not be empty';
              }
              return null;
            },
            decoration: kdecorateInput(
                hint: 'Search by ID',
                suffix: GestureDetector(
                  onTap: () {
                    // if (formKey.currentState.validate()) {
                      Navigator.pop(context, searchWord);
                    // }
                  },
                  child: Icon(
                    Icons.send,
                    color: KBlue,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
