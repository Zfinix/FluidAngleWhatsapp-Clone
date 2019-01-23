class CallModel {
  List<Call> call;

  CallModel({this.call});

  CallModel.fromJson(Map<String, dynamic> json) {
    if (json['call'] != null) {
      call = new List<Call>();
      json['call'].forEach((v) {
        call.add(new Call.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.call != null) {
      data['call'] = this.call.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Call {
  String firstName;
  String lastName;
  String date;
  String time;
  String profilePic;

  Call({this.firstName, this.lastName, this.date, this.time, this.profilePic});

  Call.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    date = json['date'];
    time = json['time'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['profilePic'] = this.profilePic;
    return data;
  }
}