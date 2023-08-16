class socketModel {
  String? message;
  Object? object;
  bool? success;

  socketModel({this.message, this.object, this.success});

  socketModel.fromJson(Map<String, dynamic> json) {
    
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
  String? message;
  String? messageType;
  Null? roomUid;
  Null? userCode;
  String? userName;
  Null? userProfilePic;

  Object(
      {this.uid,
      this.message,
      this.messageType,
      this.roomUid,
      this.userCode,
      this.userName,
      this.userProfilePic});

  Object.fromJson(Map<String, dynamic> json) {
    print('jason$json');
    uid = json['uid'];
    message = json['message'];
    messageType = json['messageType'];
    roomUid = json['roomUid'];
    userCode = json['userCode'];
    userName = json['userName'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['roomUid'] = this.roomUid;
    data['userCode'] = this.userCode;
    data['userName'] = this.userName;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
