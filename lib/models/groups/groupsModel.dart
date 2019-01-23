class GroupModel {
  List<Group> group;

  GroupModel({this.group});

  GroupModel.fromJson(Map<String, dynamic> json) {
    if (json['group'] != null) {
      group = new List<Group>();
      json['group'].forEach((v) {
        group.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.group != null) {
      data['group'] = this.group.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  String name;
  String img;
  String members;
  List<GroupMsg> groupMsg;

  Group({this.name, this.img, this.members, this.groupMsg});

  Group.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    members = json['members'];
    if (json['group_msg'] != null) {
      groupMsg = new List<GroupMsg>();
      json['group_msg'].forEach((v) {
        groupMsg.add(new GroupMsg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    data['members'] = this.members;
    if (this.groupMsg != null) {
      data['group_msg'] = this.groupMsg.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupMsg {
  String sender;
  String content;

  GroupMsg({this.sender, this.content});

  GroupMsg.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['content'] = this.content;
    return data;
  }
}