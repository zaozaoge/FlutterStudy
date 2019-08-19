import 'package:flutter/material.dart';

class TurnBox extends StatefulWidget {
  const TurnBox(
      {Key key, this.turns = .0, this.speed = 200, @required this.child})
      : super(key: key);

  final double turns; //旋转的角度
  final int speed; //过度动画执行的总时长
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    //旋转角度发生变化时执行过度动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(milliseconds: widget.speed ?? 200),
          curve: Curves.easeOut);
    }
    super.didUpdateWidget(oldWidget);
  }
}
