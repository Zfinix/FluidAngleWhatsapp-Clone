import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Camera extends StatefulWidget {
  @override
  CameraState createState() => new CameraState();
}

// SingleTickerProviderStateMixin is used for animation
class CameraState extends State<Camera> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // 1
        appBar: null,
        body: new Center(
          child: new Container(
            child: new Text("Camera"),
          ),
        ));
  }
}
