/* class InvitationModel {
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
  String? roomUid;
  String? companyName;
  String? roomName;
  List<RoomMembers>? roomMembers;
  String? invitationLink;
  bool? isJoined;
  String? roomQuestion;
  String? description;
  String? roomType;
  bool? joined;

  Object(
      {this.roomUid,
      this.companyName,
      this.roomName,
      this.roomMembers,
      this.invitationLink,
      this.isJoined,
      this.roomQuestion,
      this.description,
      this.roomType,
      this.joined});

  Object.fromJson(Map<String, dynamic> json) {
    roomUid = json['roomUid'];
    companyName = json['companyName'];
    roomName = json['roomName'];
    if (json['roomMembers'] != null) {
      roomMembers = <RoomMembers>[];
      json['roomMembers'].forEach((v) {
        roomMembers!.add(new RoomMembers.fromJson(v));
      });
    }
    invitationLink = json['invitationLink'];
    isJoined = json['isJoined'];
    roomQuestion = json['roomQuestion'];
    description = json['description'];
    roomType = json['roomType'];
    joined = json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomUid'] = this.roomUid;
    data['companyName'] = this.companyName;
    data['roomName'] = this.roomName;
    if (this.roomMembers != null) {
      data['roomMembers'] = this.roomMembers!.map((v) => v.toJson()).toList();
    }
    data['invitationLink'] = this.invitationLink;
    data['isJoined'] = this.isJoined;
    data['roomQuestion'] = this.roomQuestion;
    data['description'] = this.description;
    data['roomType'] = this.roomType;
    data['joined'] = this.joined;
    return data;
  }
}

class RoomMembers {
  String? uuid;
  String? userName;
  String? name;
  bool? isExpert;
  String? userProfilePic;

  RoomMembers(
      {this.uuid,
      this.userName,
      this.name,
      this.isExpert,
      this.userProfilePic});

  RoomMembers.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
    isExpert = json['isExpert'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['isExpert'] = this.isExpert;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
 */

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
  String? roomUid;
  String? companyName;
  String? roomName;
  List<RoomMembers>? roomMembers;
  String? invitationLink;
  bool? isJoined;
  String? roomQuestion;
  String? description;
  String? roomType;
  String? createdAt;
  bool? joined;

  Object(
      {this.roomUid,
      this.companyName,
      this.roomName,
      this.roomMembers,
      this.invitationLink,
      this.isJoined,
      this.roomQuestion,
      this.description,
      this.roomType,
      this.createdAt,
      this.joined});

  Object.fromJson(Map<String, dynamic> json) {
    roomUid = json['roomUid'];
    companyName = json['companyName'];
    roomName = json['roomName'];
    if (json['roomMembers'] != null) {
      roomMembers = <RoomMembers>[];
      json['roomMembers'].forEach((v) {
        roomMembers!.add(new RoomMembers.fromJson(v));
      });
    }
    invitationLink = json['invitationLink'];
    isJoined = json['isJoined'];
    roomQuestion = json['roomQuestion'];
    description = json['description'];
    roomType = json['roomType'];
    createdAt = json['createdAt'];
    joined = json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomUid'] = this.roomUid;
    data['companyName'] = this.companyName;
    data['roomName'] = this.roomName;
    if (this.roomMembers != null) {
      data['roomMembers'] = this.roomMembers!.map((v) => v.toJson()).toList();
    }
    data['invitationLink'] = this.invitationLink;
    data['isJoined'] = this.isJoined;
    data['roomQuestion'] = this.roomQuestion;
    data['description'] = this.description;
    data['roomType'] = this.roomType;
    data['createdAt'] = this.createdAt;
    data['joined'] = this.joined;
    return data;
  }
}

class RoomMembers {
  String? uuid;
  String? userName;
  String? name;
  bool? isExpert;
  String? userProfilePic;

  RoomMembers(
      {this.uuid,
      this.userName,
      this.name,
      this.isExpert,
      this.userProfilePic});

  RoomMembers.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
    isExpert = json['isExpert'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['isExpert'] = this.isExpert;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
