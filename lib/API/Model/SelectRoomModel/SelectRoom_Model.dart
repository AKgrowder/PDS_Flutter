class SelectRoomModel {
  String? message;
  List<Object>? object;
  bool? success;

  SelectRoomModel({this.message, this.object, this.success});

  SelectRoomModel.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  String? roomQuestion;
  String? roomType;
  String? createdDate;
  String? description;
  Null? expertUserProfile;
  Null? usersList;
  bool? isExpertPresent;

  Object(
      {this.uid,
      this.roomQuestion,
      this.roomType,
      this.createdDate,
      this.description,
      this.expertUserProfile,
      this.usersList,
      this.isExpertPresent});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    roomQuestion = json['roomQuestion'];
    roomType = json['roomType'];
    createdDate = json['createdDate'];
    description = json['description'];
    expertUserProfile = json['expertUserProfile'];
    usersList = json['usersList'];
    isExpertPresent = json['isExpertPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['roomQuestion'] = this.roomQuestion;
    data['roomType'] = this.roomType;
    data['createdDate'] = this.createdDate;
    data['description'] = this.description;
    data['expertUserProfile'] = this.expertUserProfile;
    data['usersList'] = this.usersList;
    data['isExpertPresent'] = this.isExpertPresent;
    return data;
  }
}
