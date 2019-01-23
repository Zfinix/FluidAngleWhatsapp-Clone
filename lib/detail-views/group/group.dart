import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/groups/groupsModel.dart';
import 'package:whatsapp/detail-views/group/group-details.dart';

class Groups extends StatefulWidget {
  @override
  GroupState createState() => new GroupState();
}

// SingleTickerProviderStateMixin is used for animation
class GroupState extends State<Groups> with SingleTickerProviderStateMixin {
  final response = LiveData.getGroupJSON;
  TextEditingController groupm = new TextEditingController();
  List<Group> groupsList = List();
  List<Group> temp = List();
  List<GroupMsg> groupsMsgList = List();
  var content = "";
  int length;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    Map dataMap = jsonDecode(response);
    var d = GroupModel.fromJson(dataMap);

    setState(() {
      groupsList = d.group;
    });
  }

  @override
  Widget _buildList() {
    if (temp.length > 0) {
      return ListView.builder(
          itemCount: temp.length,
          itemBuilder: (BuildContext context, int index) {
            var image;

            if (temp[index].img != null) {
              image = new Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(temp[index].img))));
            }

            if (temp[index].groupMsg != null) {
              groupsMsgList = temp[index].groupMsg;
              content = groupsMsgList[index].sender +
                  ": " +
                  groupsMsgList[index].content;
            }
            if (index < temp.length) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupDetail(groups: temp[index]),
                          ),
                        );
                      },
                      leading: image,
                      title: Row(
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
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          temp[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Text(
                                        "10:30 PM",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0),
                                    ),
                                  )
                                ],
                              ),
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
    } else {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var image;

            if (groupsList[index].img != null) {
              image = new Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(groupsList[index].img))));
            }

            if (groupsList[index].groupMsg != null) {
              groupsMsgList = groupsList[index].groupMsg;
              content = groupsMsgList[index].sender +
                  ": " +
                  groupsMsgList[index].content;
            }

            if (temp.length < groupsList.length) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupDetail(groups: groupsList[index]),
                          ),
                        );
                      },
                      leading: image,
                      title: Row(
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
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          groupsList[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Text(
                                        "10:30 PM",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0),
                                    ),
                                  )
                                ],
                              ),
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
          },
          itemCount: groupsList.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 0.70;
    return new Material(
        child: new Center(
      child: Container(
        color: Colors.white,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[Flexible(child: _buildList())],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    heroTag: "fab",
                    onPressed: () {
                      _showDialog();
                    },
                    child: Icon(Icons.message, color: Colors.white),
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextFormField(
                controller: groupm,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: "Group Name", hintText: 'Group Name'),
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
                //TRYING TO ADD NEEW ITEM TO LIST ON CLICK
                List<GroupMsg> addMsg = List();
                 temp = List();
                temp.add(Group(
                    img: "http://dummyimage.com/300x500.png/cc0000/ffffff",
                    name: groupm.text,
                    members: "You",
                    groupMsg: addMsg));
                groupsList.length++;
                setState(() {
                  addMsg.add(GroupMsg(content: "", sender: ""));

                  groupsList = temp;
                  Navigator.pop(context);
                });
              })
        ],
      ),
    );
  }
  
}
