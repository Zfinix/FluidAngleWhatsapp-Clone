class OStatus {
  List<Status> status;

  OStatus({this.status});

  OStatus.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = new List<Status>();
      json['status'].forEach((v) {
        status.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String name;
  String message;
  String time;

  Status({this.name, this.message, this.time});

  Status.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}
