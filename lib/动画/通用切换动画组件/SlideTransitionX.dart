import 'package:flutter/material.dart';

class SlideTransitionX extends AnimatedWidget {
  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction; //退场方向
  Tween<Offset> tween;

  SlideTransitionX(
      {Key key,
      this.transformHitTests = true,
      this.child,
      this.direction,
      @required Animation<double> position})
      : assert(position != null),
        super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.down:
        tween = Tween(begin: Offset(.0, -1.0), end: Offset(.0, .0));
        break;
      case AxisDirection.up:
        tween = Tween(begin: Offset(.0, 1.0), end: Offset(.0, .0));
        break;
      case AxisDirection.left:
        tween = Tween(begin: Offset(1.0, .0), end: Offset(.0, .0));
        break;
      case AxisDirection.right:
        tween = Tween(begin: Offset(-1.0, .0), end: Offset(.0, .0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
