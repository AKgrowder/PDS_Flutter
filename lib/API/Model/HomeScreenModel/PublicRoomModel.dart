// class PublicRoomModel {
//   String? message;
//   List<Object>? object;
//   bool? success;

//   PublicRoomModel({this.message, this.object, this.success});

//   PublicRoomModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['object'] != null) {
//       object = <Object>[];
//       json['object'].forEach((v) {
//         object!.add(new Object.fromJson(v));
//       });
//     }
//     success = json['success'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.object != null) {
//       data['object'] = this.object!.map((v) => v.toJson()).toList();
//     }
//     data['success'] = this.success;
//     return data;
//   }
// }

// class Object {
//   String? uid;
//   String? roomQuestion;
//   String? roomType;
//   Null? user;
//   Message? message;

//   Object({this.uid, this.roomQuestion, this.roomType, this.user, this.message});

//   Object.fromJson(Map<String, dynamic> json) {
//     uid = json['uid'];
//     roomQuestion = json['roomQuestion'];
//     roomType = json['roomType'];
//     user = json['user'];
//     message =
//         json['message'] != null ? new Message.fromJson(json['message']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uid'] = this.uid;
//     data['roomQuestion'] = this.roomQuestion;
//     data['roomType'] = this.roomType;
//     data['user'] = this.user;
//     if (this.message != null) {
//       data['message'] = this.message!.toJson();
//     }
//     return data;
//   }
// }

// class Message {
//   String? uid;
//   String? message;
//   String? messageType;
//   String? userName;
//   int? messageCount;

//   Message(
//       {this.uid,
//       this.message,
//       this.messageType,
//       this.userName,
//       this.messageCount});

//   Message.fromJson(Map<String, dynamic> json) {
//     uid = json['uid'];
//     message = json['message'];
//     messageType = json['messageType'];
//     userName = json['userName'];
//     messageCount = json['messageCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uid'] = this.uid;
//     data['message'] = this.message;
//     data['messageType'] = this.messageType;
//     data['userName'] = this.userName;
//     data['messageCount'] = this.messageCount;
//     return data;
//   }
// }


class PublicRoomModel {
  String? message;
  List<Object>? object;
  bool? success;

  PublicRoomModel({this.message, this.object, this.success});

  PublicRoomModel.fromJson(Map<String, dynamic> json) {
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
  Null? user;
  Message? message;

  Object({this.uid, this.roomQuestion, this.roomType, this.user, this.message});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    roomQuestion = json['roomQuestion'];
    roomType = json['roomType'];
    user = json['user'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['roomQuestion'] = this.roomQuestion;
    data['roomType'] = this.roomType;
    data['user'] = this.user;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? uid;
  String? message;
  String? messageType;
  String? userName;
  int? messageCount;
  Null? userCode;
  Null? userProfilePic;

  Message(
      {this.uid,
      this.message,
      this.messageType,
      this.userName,
      this.messageCount,
      this.userCode,
      this.userProfilePic});

  Message.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    message = json['message'];
    messageType = json['messageType'];
    userName = json['userName'];
    messageCount = json['messageCount'];
    userCode = json['userCode'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['userName'] = this.userName;
    data['messageCount'] = this.messageCount;
    data['userCode'] = this.userCode;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
