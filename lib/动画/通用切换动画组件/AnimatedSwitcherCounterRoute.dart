import 'package:flutter/material.dart';
import 'MySlideTransition.dart';
import 'SlideTransitionX.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("MyApp"),
        ),
        body: AnimatedSwitcherCounterRoute(),
      ),
    );
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedSwitcherCounterRouteState();
  }
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
//              return ScaleTransition(
//                scale: animation,
//                child: child,
//              );
              /*  var tween =
                  Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(.0, .0));
              return SlideTransition(
                position: tween.animate(animation),
                child: child,
              );*/
//              var tween =
//                  Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(.0, .0));
//              return MySlideTransition(
//                position: tween.animate(animation),
//                child: child,
//              );
              return SlideTransitionX(
                position: animation,
                child: child,
                direction: AxisDirection.up,
              );
            },
            child: Text(
              "$_count",
              //显示指定的key，不同的key会被认为是不同的text,这样才能执行动画
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
            child: const Text("+1"),
          )
        ],
      ),
    );
  }
}
