import 'package:AUIS_classroom/constants.dart';
import 'package:AUIS_classroom/services/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatelessWidget {
  Video(this.url, this._id,);
  final String url;
  final _id;
  bool isAdmin;
  get getId => _id;

  YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    isAdmin = Provider.of<User>(context).isAdmin;
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
        ));
    if (isAdmin) {
      return adminVideo();
    } else {
      return studentVideo();
    }
  }

  Widget adminVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
      ),
    );
  }

  Widget studentVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
      ),
    );
  }
}
