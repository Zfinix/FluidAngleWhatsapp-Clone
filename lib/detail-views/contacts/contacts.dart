import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp/liveData/liveData.dart';
import 'package:whatsapp/models/contacts/contactsModel.dart';

class Contacts extends StatefulWidget {
  @override
  ContactsState createState() => new ContactsState();
}

// SingleTickerProviderStateMixin is used for animation
class ContactsState extends State<Contacts>
    with SingleTickerProviderStateMixin {

  final response = LiveData.getContactsJSON;
  List<Contact> contactsList = List();

//Fetching data from LiveData
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

//Fetching data from LiveData
  _fetchData() async {
    setState(() {
      contactsList = (json.decode(response) as List)
          .map((data) => new Contact.fromJson(data))
          .toList();
    });
  }

  @override
  Widget _buildList() {
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
                  onTap: () {},
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
                                  Text(
                                    contactsList[index].firstName +
                                        " " +
                                        contactsList[index].lastName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0),
                                  )
                                ],
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
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 0.70;
    return new Center(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  color: Colors.green,
                  child: Column(
                    children: <Widget>[
                      Container(
                          color: Colors.green,
                          child: SizedBox(
                            height: 20,
                          )),
                      AppBar(title: new Text("Contact")),
                    ],
                  )),
              Flexible(child: _buildList())
            ],
          ),
        ),
      ),
    );
  }
}
