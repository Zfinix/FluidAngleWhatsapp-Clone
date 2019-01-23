import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/contacts/contactsModel.dart';
import 'package:whatsapp/models/groups/groupsModel.dart';
import 'package:whatsapp/detail-views/contacts/contacts.dart';

class GroupDetail extends StatefulWidget {
  @override
  final Group groups;
  // In the constructor, require a Group of the groups details
  GroupDetail({Key key, @required this.groups}) : super(key: key);
  GroupState createState() => new GroupState(groups: groups);
}

// SingleTickerProviderStateMixin is used for animation
class GroupState extends State<GroupDetail> {
  final Group groups;

  //ADD CONTACT TO CHATS
  final response = LiveData.getContactsJSON;
  List<Contact> contactsList = List();
  final key = new GlobalKey<ScaffoldState>();
  //List for messages
  var addedText, added;
  List<GroupMsg> msgList;
  // In the constructor, require a Group
  GroupState({Key key, @required this.groups});

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

//Fetchint data from LiveData
  _fetchData() async {
    setState(() {
      msgList = groups.groupMsg;
      contactsList = (json.decode(response) as List)
          .map((data) => new Contact.fromJson(data))
          .toList();
    });
  }

  @override
  Widget addContacts() {
    return ListView.builder(
        itemCount: contactsList.length,
        itemBuilder: (BuildContext context, int index) {
          var image;
          if (contactsList[index].profilePic != null) {
            image = new Container(
                width: 56.0,
                height: 56.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            new NetworkImage(contactsList[index].profilePic))));
          }
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: image,
                  onTap: () {
                    // Navigator.pop(context);
                    setState(() {
                      addedText = "Added " +
                          contactsList[index].firstName +
                          " to group chat";

                          added = Card(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(addedText),
                          ));
                    });
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text("Added " +
                          contactsList[index].firstName +
                          " to group chat"),
                    ));
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
                                Text(
                                  contactsList[index].firstName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                )
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
        });
  }



  Widget _buildList() {
    //Building messages List on Fab click
    double width = MediaQuery.of(context).size.width * 0.64;
    return ListView.builder(
       // itemBuilder will be automatically be called as many times as it takes for the
      // list to fill up its available space, which is most likely more than the
      // number of group items we have. So, we need to check the index is OK.

        itemCount: msgList.length,
        itemBuilder: (BuildContext context, int index) {
          var card;

          //Arranging ent and recieved mesages based on sender value
          if (msgList[index].sender.contains("You")) {
            card = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                card = new Card(
                  elevation: 3,
                  child: SizedBox(
                    width: width,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(msgList[index].sender +
                          ": " +
                          msgList[index].content),
                    ),
                  ),
                ),
              ],
            );
          } else {
            card = Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                card = new Card(
                  elevation: 3,
                  child: SizedBox(
                    width: width,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(msgList[index].sender +
                          ": " +
                          msgList[index].content),
                    ),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Card for messages
                child: ListTile(title: card),
              ),
            ],
          );
        });
  }

//Layout for group contacts for scaffold
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/icons/contact_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(title: new Text(groups.name)),
                  Flexible(child: _buildList())
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab",
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.amber,
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
        context: context,
        child: Scaffold(
          body: new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[new Expanded(child: addContacts())],
            ),
          ),
        ));
  }
}
