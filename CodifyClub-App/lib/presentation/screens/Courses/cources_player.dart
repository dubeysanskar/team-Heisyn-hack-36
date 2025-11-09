import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const YoutubeVideoPlayer({super.key, required this.videoUrl});

  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;  // Added to track if the player is ready

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if (videoId != null) {
      print("Video ID: $videoId");

      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
         // isLive:true,
          autoPlay: false,        // Can set to true for autoplay
          controlsVisibleAtStart: true,
          mute: false,
          forceHD: true,
        ),
      )..addListener(_listener);
    }
  }

  void _listener() {
    // Once the controller is ready, we can interact with it
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      print("Player state: ${_controller!.value.playerState}");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _controller != null
          ? YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.redAccent,
        onReady: () {
          print("Player is ready.");

          setState(() {
            _isPlayerReady = true;  // Update the state once the player is ready
          });
        },
        onEnded: (data) {
          print("Video has ended");
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
