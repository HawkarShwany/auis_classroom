import 'package:flutter/material.dart';
import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatelessWidget {
  Video(this.url);
  final String url;

  YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      )
    );
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
      ),
    );
  }
}
