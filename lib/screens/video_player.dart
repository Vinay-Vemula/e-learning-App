import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;
  const VideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    super.initState();
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoPlay: true,
            looping: true,
            fullScreenByDefault: false);
    _betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.videoUrl);

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: videoPlayer(),
    );
  }

  videoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
