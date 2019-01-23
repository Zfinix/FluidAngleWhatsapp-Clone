import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileDetail extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

// SingleTickerProviderStateMixin is used for animation
class ProfileState extends State<ProfileDetail>
    with SingleTickerProviderStateMixin {
  Widget _buildAvatar() {
    return Image.asset("assets/icons/profile.png", scale: 4.5);
  }

  ///FIELD FOR NAME
  final name = TextFormField(
    keyboardType: TextInputType.text,
    autofocus: false,
    initialValue: "Ogbonda Chiziaruhoma",
    decoration: InputDecoration(
      labelText: 'Name',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    /* Not Using Scaffold to fix the bug of layout flying out on focus in an TextForm Field  */
    return new Container(
        child: new Center(
      child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: new ListView(
            children: <Widget>[
              Container(color: Colors.green, child: SizedBox(height: 20)),
              AppBar(title: new Text("Profile")),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    _buildAvatar(),
                    name,
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person, size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Account",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.info, size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "About",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.save, size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Save",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    ));
  }
}
