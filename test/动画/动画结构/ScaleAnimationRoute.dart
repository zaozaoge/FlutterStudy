import 'package:flutter/material.dart';

void main() {
  runApp(ScaleAnimationRoute());
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState();
  }
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    _animation = Tween(begin: 0.0, end: 800.0).animate(_controller)
      ..addListener(() {
        setState((){});
      });
    //启动动画，正向执行
    _controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "./images/test.png",
        width: _animation.value,
        height: _animation.value,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
