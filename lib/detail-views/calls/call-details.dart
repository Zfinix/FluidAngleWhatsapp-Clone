import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CallsDetail extends StatefulWidget {
  @override
  CallState createState() => new CallState();
}

// SingleTickerProviderStateMixin is used for animation
class CallState extends State<CallsDetail> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // 1
        appBar: null,
        body: new Center(
          child: new Container(
            child: new Text("Calls Detail"),
          ),
        ));
  }
}
