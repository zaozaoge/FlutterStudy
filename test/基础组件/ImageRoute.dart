import 'package:flutter/material.dart';

void main() {
  runApp(ImageRoute());
}

class ImageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image组件"),
        ),
        body: ClipOvalContent(),
      ),
    );
  }
}

class ClipOvalContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.0,
        height: 300.0,
        child: ClipOval(
          child: Image.network(
            "http://f.hiphotos.baidu.com/image/h%3D300/sign=d985fb87d81b0ef473e89e5eedc551a1/b151f8198618367aa7f3cc7424738bd4b31ce525.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class HomeContentCircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.0,
        height: 300.0,
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.white, width: 5.0),
            image: DecorationImage(
                image: NetworkImage(
                    "http://e.hiphotos.baidu.com/image/h%3D300/sign=a9e671b9a551f3dedcb2bf64a4eff0ec/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg")),
            borderRadius: BorderRadius.all(Radius.circular(150.0))),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(150.0))),
        width: 300.0,
        height: 300.0,
        child: Image.network(
          "http://f.hiphotos.baidu.com/image/h%3D300/sign=0c78105b888ba61ec0eece2f713597cc/0e2442a7d933c8956c0e8eeadb1373f08202002a.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
