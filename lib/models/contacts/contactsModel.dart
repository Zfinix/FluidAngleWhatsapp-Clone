class ContactModel {
  List<Contact> contact;

  ContactModel({this.contact});

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['contact'] != null) {
      contact = new List<Contact>();
      json['contact'].forEach((v) {
        contact.add(new Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contact != null) {
      data['contact'] = this.contact.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contact {
  String firstName;
  String lastName;
  String profilePic;
  Contact(
      {this.firstName,
      this.lastName,
      this.profilePic});

  Contact.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    
    return data;
  }
}
