import 'package:flutter/material.dart';
import 'GradientCircularProgressIndicator.dart';

void main() {
  runApp(GradientCircularProgressRoute());
}

class GradientCircularProgressRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradientCircularProgressRoute();
  }
}

class _GradientCircularProgressRoute
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    bool isForward = true;
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GradientCircularProgressRoute"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: getSingleChildScrollView(),
          ),
        ),
      ),
    );
  }

  Widget getSingleChildScrollView() {
    return Center(
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 10.0,
            runSpacing: 16.0,
            children: <Widget>[
              GradientCircularProgressIndicator(
                radius: 50.0,
                colors: [Colors.blue, Colors.blue],
                strokeWidth: 3.0,
                value: _controller.value,
              ),
              GradientCircularProgressIndicator(
                radius: 50.0,
                colors: [Colors.red, Colors.orange,Colors.green],
                strokeWidth: 3.0,
                value: _controller.value,
              )
            ],
          )
        ],
      ),
    );
  }
}
