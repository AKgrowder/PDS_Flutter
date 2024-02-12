class PersonalChatListModel {
  String? message;
  List<Object>? object;
  bool? success;

  PersonalChatListModel({this.message, this.object, this.success});

  PersonalChatListModel.fromJson(Map<String, dynamic> json) {
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
  String? userChatInboxUid;
  String? userChatMessageUid;
  String? userName;
  String? userProfilePic;
  String? message;
  String? createdDate;
  String? messageType;
  bool? onlineStatus;
  String? userUid;
  bool? isSeen;

  Object(
      {this.userChatInboxUid,
      this.userChatMessageUid,
      this.userName,
      this.userProfilePic,
      this.message,
      this.createdDate,
      this.onlineStatus,
      this.messageType,this.userUid,this.isSeen});

  Object.fromJson(Map<String, dynamic> json) {
    userChatInboxUid = json['userChatInboxUid'];
    userChatMessageUid = json['userChatMessageUid'];
    userName = json['userName'];
    userProfilePic = json['userProfilePic'];
    message = json['message'];
    createdDate = json['createdDate'];
    messageType = json['messageType'];
    onlineStatus = json['onlineStatus'];
    userUid = json['userUid'];
    isSeen = json['isSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userChatInboxUid'] = this.userChatInboxUid;
    data['userChatMessageUid'] = this.userChatMessageUid;
    data['userName'] = this.userName;
    data['userProfilePic'] = this.userProfilePic;
    data['message'] = this.message;
    data['createdDate'] = this.createdDate;
    data['messageType'] = this.messageType;
    data['onlineStatus'] = this.onlineStatus;
    data['userUid'] = this.userUid;
    data['isSeen'] = this.isSeen;
    return data;
  }
}
