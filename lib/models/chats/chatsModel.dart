class ChatsModel {
  List<Chats> chats;

  ChatsModel({this.chats});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = new List<Chats>();
      json['chats'].forEach((v) {
        chats.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String firstName;
  String lastName;
  bool online;
  String mostRecentMessages;
  String time;
  List<Msg> msg;
  String profilePicture;

  Chats(
      {this.firstName,
      this.lastName,
      this.online,
      this.mostRecentMessages,
      this.time,
      this.msg,
      this.profilePicture});

  Chats.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    online = json['online'];
    mostRecentMessages = json['most_recent_messages'];
    time = json['time'];
    if (json['msg'] != null) {
      msg = new List<Msg>();
      json['msg'].forEach((v) {
        msg.add(new Msg.fromJson(v));
      });
    }
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['online'] = this.online;
    data['most_recent_messages'] = this.mostRecentMessages;
    data['time'] = this.time;
    if (this.msg != null) {
      data['msg'] = this.msg.map((v) => v.toJson()).toList();
    }
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}

class Msg {
  bool sent;
  String message;

  Msg({this.sent,this.message});

  Msg.fromJson(Map<String, dynamic> json) {
    sent = json['sent'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sent'] = this.sent;
    data['message'] = this.message;
    return data;
  }
}
