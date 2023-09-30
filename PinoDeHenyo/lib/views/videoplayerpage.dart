import 'package:flutter/material.dart';
import 'package:youtube_app/model/cartoons_model.dart';
import 'package:youtube_app/designs/colors/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerPage extends StatefulWidget {
  const YoutubeVideoPlayerPage({super.key, required this.cartoonsModel});

  final CartoonsModel cartoonsModel;

  @override
  State<YoutubeVideoPlayerPage> createState() => _YoutubeVideoPlayerPageState();
}

class _YoutubeVideoPlayerPageState extends State<YoutubeVideoPlayerPage> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: widget.cartoonsModel.videoId,
        flags: const YoutubePlayerFlags(
            autoPlay: true, mute: true, isLive: false));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: secondaryColor,
        progressColors: ProgressBarColors(
            playedColor: secondaryColor, handleColor: Colors.white),
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.cartoonsModel.text),
            backgroundColor: darkPrimarybgColor,
          ),
          body: Column(
            children: [
              player,
              Expanded(
                  child: Container(
                color: darkSecondarybgColor,
              ))
            ],
          ),
        );
      },
    );
  }
}
