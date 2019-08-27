import 'package:flutter/material.dart';

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Image.asset(
      "./images/test.png",
      width: animation.value,
      height: animation.value,
    );
  }
}


void main(){
  runApp(ScaleAnimationRoute1());
}
class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState();
  }
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: 0.0, end: 300.0).animate(_controller);
    //启动动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedImage(
      animation: _animation,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
