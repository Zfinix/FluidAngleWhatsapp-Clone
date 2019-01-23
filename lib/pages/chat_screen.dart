import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/chats/chatsModel.dart';
import 'package:whatsapp/detail-views/chats/chats-details.dart';

class ChatScreen extends StatefulWidget {
  @override
  ChatsState createState() => new ChatsState();
}

// SingleTickerProviderStateMixin is used for animation
class ChatsState extends State<ChatScreen> {
  /* Fetchingg data from livedata class*/
  final response = LiveData.getChatJSON;
  List<Chats> chatsList = List();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

//
  _fetchData() async {
    /* Mapping data to list*/
    Map dataMap = jsonDecode(response);
    var d = ChatsModel.fromJson(dataMap);

    setState(() {
      chatsList = d.chats;
    });
  }

  @override
  Widget _buildList() {
    return ListView.builder(
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of chat items we have. So, we need to check the index is OK.

        itemCount: chatsList.length,
        itemBuilder: (BuildContext context, int index) {
          var image;
          if (chatsList[index].profilePicture != null) {
            image = new Container(
                width: 56.0,
                height: 56.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            chatsList[index].profilePicture))));
          }
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
                            ChatsDetail(chats: chatsList[index]),
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
                                Text(
                                  chatsList[index].firstName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                                Text(
                                  chatsList[index].time,
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 7.0),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                chatsList[index].mostRecentMessages,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13.0),
                              ),
                            )
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // 1
      appBar: null,
      body: new Center(
        child: Column(
          children: <Widget>[Flexible(child: _buildList())],
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: new Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () => _showDialog(),
      ),
    );
  }

//DIALOG FOR ONCLICK OF FAB
  _showDialog() async {
    await showDialog<String>(
        context: context,
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[new Expanded(child: _buildList())],
          ),
        ));
  }
}
