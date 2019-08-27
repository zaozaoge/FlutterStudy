import 'package:flutter/material.dart';

void main() {
  runApp(new ScrollerControllerTestRoute());
}

class ScrollerControllerTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ScrollerControllerTestRouteState();
  }
}

class ScrollerControllerTestRouteState
    extends State<ScrollerControllerTestRoute> {
  ScrollController _controller = new ScrollController(); //用来控制组件中的滚动位置
  bool _showToTopBtn = false; //是否显示返回到顶部的按钮

  @override
  void initState() {
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
      setState(() {
        _showToTopBtn = (_controller.offset >= 1000);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    //为了避免内存泄漏，需要调用
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('滚动控制'),
        ),
        body: Scrollbar(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
          itemCount: 100,
          itemExtent: 50.0,
          controller: _controller,
        )),
        floatingActionButton: !_showToTopBtn
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _controller.animateTo(0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: Icon(Icons.arrow_upward),
              ),
      ),
    );
  }
}
