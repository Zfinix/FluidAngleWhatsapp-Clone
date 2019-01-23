import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp/detail-views/status/status-detail.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/status/otherStatusModel.dart';

class StatusScreen extends StatefulWidget {
  @override
  StatusState createState() => new StatusState();
}

// SingleTickerProviderStateMixin is used for animation
class StatusState extends State<StatusScreen> {
  TextEditingController status = new TextEditingController();
  List<String> statItems = [];
  final response = LiveData.getStatusJSON;
  List<Status> statusList = List();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

//
  _fetchData() async {
    Map dataMap = jsonDecode(response);
    var d = OStatus.fromJson(dataMap);

    setState(() {
      statusList = d.status;
    });
  }

  // This will be called each time the + button is pressed

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextFormField(
                controller: status,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: "", hintText: 'Type Status Here'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('CREATE'),
              onPressed: () {
                if (statItems.length < 1) {
                  setState(() {
                    statItems.add(status.text);
                    Navigator.pop(context);
                  });
                } else {
                  statItems.add(status.text);
                  Navigator.pop(context);
                }
              })
        ],
      ),
    );
  }

  // Build the whole list of status items
  Widget _buildStatusList() {
    return new ListView.builder(itemBuilder: (context, index) {
      // itemBuilder will be automatically be called as many times as it takes for the
      // list to fill up its available space, which is most likely more than the
      // number of status items we have. So, we need to check the index is OK.

      var image = new Container(
          width: 56.0,
          height: 56.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(
                      "http://dummyimage.com/300x500.png/cc0000/ffffff"))));
      if (index < statItems.length) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: image,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusDetail(statItems[index], statusList),
                    ),
                  );
                },
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 200,
                                child: Text(
                                  statItems[index],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        );
      }
    });
  }

  Widget _buildOtherStatusList() {
    return new ListView.builder(
        itemCount: statusList.length,
        itemBuilder: (context, index) {
          // itemBuilder will be automatically be called as many times as it takes for the
          // list to fill up its available space, which is most likely more than the
          // number of status items we have. So, we need to check the index is OK.

          var image = new Container(
              width: 56.0,
              height: 56.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "http://dummyimage.com/300x500.png/cc0000/ffffff"))));
          if (index < statusList.length) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: image,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StatusDetail(statusList[index].message, null),
                        ),
                      );
                    },
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      statusList[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      statusList[index].time,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 100, child: _buildStatusList()),
            Container(
                color: Theme.of(context).primaryColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Recent updates",
                            style: TextStyle(color: Colors.white)),
                      )
                    ])),
            Flexible(child: _buildOtherStatusList()),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () => _showDialog(),
        ));
  }
}
