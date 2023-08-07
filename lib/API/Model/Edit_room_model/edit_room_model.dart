class EditRoomModel {
  String? message;
  Object? object;
  bool? success;

  EditRoomModel({this.message, this.object, this.success});

  EditRoomModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Object {
  String? uid;
  String? roomQuestion;
  String? roomType;
  Null? createdDate;
  String? description;
  Null? usersList;

  Object(
      {this.uid,
      this.roomQuestion,
      this.roomType,
      this.createdDate,
      this.description,
      this.usersList});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    roomQuestion = json['roomQuestion'];
    roomType = json['roomType'];
    createdDate = json['createdDate'];
    description = json['description'];
    usersList = json['usersList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['roomQuestion'] = this.roomQuestion;
    data['roomType'] = this.roomType;
    data['createdDate'] = this.createdDate;
    data['description'] = this.description;
    data['usersList'] = this.usersList;
    return data;
  }
}
