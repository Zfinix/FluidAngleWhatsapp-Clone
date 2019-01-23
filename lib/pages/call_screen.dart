import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/calls/callsModel.dart';

class CallScreen extends StatefulWidget {
  @override
  CallState createState() => new CallState();
}

// SingleTickerProviderStateMixin is used for animation
class CallState extends State<CallScreen> {
  /* Fetching call live data */
  final response = LiveData.getCallJSON;
  List<Call> callsList = List();
 
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
      /* Sending parsed json to list*/
    Map dataMap = jsonDecode(response);
    var d = CallModel.fromJson(dataMap);

    setState(() {
      callsList = d.call;
    });
  }

  @override
  Widget _buildList() {

      /* Building Call list*/
    return ListView.builder(
        itemCount: callsList.length,
        itemBuilder: (BuildContext context, int index) {
          var image;

      //    callsDataList = callsList[index].calls;

          if (callsList[index].profilePic != null) {
            image = new Container(
                width: 56.0,
                height: 56.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(callsList[index].profilePic))));
          }

          return Column(
            children: <Widget>[
              ListTile(
                  leading: image,
                  title: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          callsList[index].firstName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0),
                                        ),
                                        Text(
                                          callsList[index].time,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.0),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                       callsList[index].date,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 9.0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              Divider(),
            ],
          );
        });
  }
//Building Call list
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // 1
        appBar: null,
        body: new Center(
          child: Column(
            children: <Widget>[Flexible(child: _buildList())],
          ),
        ));
  }
}
