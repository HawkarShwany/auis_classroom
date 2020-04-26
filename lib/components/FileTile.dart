import 'dart:io';
import 'package:AUIS_classroom/services/network.dart' as Network;
import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class FileTile extends StatelessWidget {
  final id;
  final name;
  Function delete;
  final score;
  Function upvote;
  Function downvote;
  FileTile(
      {@required this.id,
      @required this.name,
      this.delete,
      this.score,
      this.upvote,
      this.downvote});

  Widget buttons(BuildContext context) {
    if (!Provider.of<User>(context, listen: false).isAdmin) {
      return Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              upvote(id);
            },
            child: Icon(
              Icons.keyboard_arrow_up,
              color: KGreen,
            ),
          ),
          GestureDetector(
            onTap: () {
              downvote(id);
            },
            child: Icon(
              Icons.keyboard_arrow_down,
              color: KYellow,
            ),
          ),
          Text(score.toString()),
        ],
      );
    } else {
      return GestureDetector(
          onTap: () {
            delete(id);
          },
          child: Icon(
            Icons.delete_forever,
            color: KPrimaryColor,
          ));
    }
  }

  void openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: KSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: GestureDetector(
              onTap: () async {
                if (kIsWeb) {
                  String url =
                      'http://192.168.1.9:8081/capstone/web/upload.php?fileId=' +
                          id;
                  openUrl(url);
                } else {
                  File file = await Network.downloadFile(id);
                  OpenFile.open(file.path);
                }

                // print('file pathh:   '+file.path);
              },
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          buttons(context),
        ],
      ),
    );
  }
}
