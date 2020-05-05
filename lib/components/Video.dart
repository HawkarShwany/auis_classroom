import 'package:AUIS_classroom/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Video extends StatelessWidget {
  Video(
    this.name,
    this.url,
    this._id,
  );
  final name;
  final String url;
  final _id;
  get getId => _id;

  YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
        ));
    if (kIsWeb) {
      return web();
    } else {
      return mobileVideo();
    }
  }

  Widget web() {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 4,
        child: FlatButton(
          onPressed: () => openUrl(),
          child: Text(
            name,
            style: TextStyle(color: KBlue),
          ),
        ),
      ),
    );
  }

  Widget mobileVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child:
          //   apiKey: 'AIzaSyCHk9Yw79jjnN3wqd4JTXD4MsN0JWzpA-c',
          YoutubePlayer(
        controller: _controller,
      ),
    );
  }

  void openUrl() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
