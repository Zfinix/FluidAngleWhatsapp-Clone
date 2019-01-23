import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/chats/chatsModel.dart';

class ChatsDetail extends StatefulWidget {
  @override
  final Chats chats;
  // In the constructor, require a Chat
  ChatsDetail({Key key, @required this.chats}) : super(key: key);
  ChatState createState() => new ChatState(chats: chats);
}

// SingleTickerProviderStateMixin is used for animation
class ChatState extends State<ChatsDetail> {
  final Chats chats;
  List<Msg> msgList;
  // In the constructor, require a Chat Object
  ChatState({Key key, @required this.chats});

  TextEditingController messageController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

/* Trying to  fetch data from constructor in to Local list  */
  _fetchData() async {
    setState(() {
      msgList = chats.msg;
      print(msgList);
    });
  }

  @override
  Widget _buildList() {
    /* Using the width of the device to layout specific items */
    double width = MediaQuery.of(context).size.width * 0.60;

    /* Creating listview fro messahes */
    return ListView.builder(
        itemCount: msgList.length,
        itemBuilder: (BuildContext context, int index) {
          var card;

          /* Aligning messages to the left or to the right based on the properties of
          its sent jsonkey*/
          if (msgList[index].sent) {
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: card = Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  card = new Card(
                    elevation: 3,
                    child: SizedBox(
                      width: width,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(msgList[index].message),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: card = Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  card = new Card(
                    elevation: 3,
                    child: SizedBox(
                      width: width,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(msgList[index].message),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: <Widget>[
              card,
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 0.70;
    /* Not Using Scaffold to fix the bug of layout rlying out on focus in an TextForm Field  */
    return new Material(
        child: new Center(
      child: Container(
        color: Colors.white,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/icons/chat_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    /* Building AppBar  */
                    AppBar(
                        title:
                            new Text(chats.firstName + " " + chats.lastName)),
                    Flexible(child: _buildList()),
                    // Input content
                    buildInput(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
                controller: messageController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  sendMessage();
                },
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
         
          color: Colors.white),
    );
  }

  void sendMessage() {
    setState(() {
      
      msgList.add(Msg(sent: true, message: messageController.text));
      messageController.clear();
      
    });
  }
}
