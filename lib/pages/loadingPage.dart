import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import '../widgetTree.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int _shapeIndex = 0;
  late VideoPlayerController _controller;
  final List<Widget> _shapes = [
    const SpinKitSquareCircle(color: Colors.white),
    const SpinKitCircle(color: Colors.white),
    const SpinKitFadingCube(color: Colors.white),
  ];

  void listener() {
    if (_controller.value.hasError) {
      print(_controller.value.errorDescription);
    }
  }

  @override
  void initState() {
    super.initState();
    _changeShape();
    _controller = VideoPlayerController.asset('assets/background.mp4')
      ..initialize().then((_) {
        _controller.setPlaybackSpeed(0.2);
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      })
      ..addListener(listener);
      callNextPage();
  }

  bool _isActive = true;

  Timer? _timer;

  void _changeShape() {
    _timer = Timer(const Duration(seconds: 3), () {
      //prevent setting state while page is not active
      if (!_isActive) return;

      if(mounted) {
        setState(() {
        _shapeIndex = (_shapeIndex + 1) % _shapes.length;
      });
      }

        _changeShape();
    });

    
  }
  callNextPage(){
    //navigate to the next page in 10 seconds, also dispose this current page
    Future.delayed(const Duration(seconds: 10), () {
      _isActive = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthTree()),
      );
    });

  }

  @override
  void dispose() {
    _isActive = false;
    _timer?.cancel();
    _controller.removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45
                ],
              ),
            ),
          ),
          //adjust the sigmaX and sigmaY values in the ImageFilter.blur to control the amount of blur, and the opacity of the white color in the Container to control the intensity of the frosted glass effect.
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              //white for frosted glass effect
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _shapes[_shapeIndex],
          ),
        ],
      ),
    );
  }
}
//extra videos
// https://player.vimeo.com/external/319226268.sd.mp4?s=d4875195ee3dc70726af5d0709cbda9efc4afeaa&profile_id=164&oauth2_token_id=57447761
// b and red smoke https://vod-progressive.akamaized.net/exp=1705434072~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2398%2F19%2F486994361%2F2182531149.mp4~hmac=8b0d467551f62f17a8306f9ba142316ae2d47a6ad5aa730c7b254687ef261023/vimeo-prod-skyfire-std-us/01/2398/19/486994361/2182531149.mp4
