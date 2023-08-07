class InvitationModel {
  String? message;
  List<Object>? object;
  bool? success;

  InvitationModel({this.message, this.object, this.success});

  InvitationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['object'] != null) {
      object = <Object>[];
      json['object'].forEach((v) {
        object!.add(new Object.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Object {
  String? companyName;
  String? roomName;
  Null? roomMembers;
  String? invitationLink;
  bool? isJoined;
  String? roomQuestion;
  String? description;
  String? roomType;
  bool? joined;

  Object(
      {this.companyName,
      this.roomName,
      this.roomMembers,
      this.invitationLink,
      this.isJoined,
      this.roomQuestion,
      this.description,
      this.roomType,
      this.joined});

  Object.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    roomName = json['roomName'];
    roomMembers = json['roomMembers'];
    invitationLink = json['invitationLink'];
    isJoined = json['isJoined'];
    roomQuestion = json['roomQuestion'];
    description = json['description'];
    roomType = json['roomType'];
    joined = json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['roomName'] = this.roomName;
    data['roomMembers'] = this.roomMembers;
    data['invitationLink'] = this.invitationLink;
    data['isJoined'] = this.isJoined;
    data['roomQuestion'] = this.roomQuestion;
    data['description'] = this.description;
    data['roomType'] = this.roomType;
    data['joined'] = this.joined;
    return data;
  }
}
