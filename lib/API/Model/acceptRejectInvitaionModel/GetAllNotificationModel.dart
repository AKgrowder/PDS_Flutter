class GetAllNotificationModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetAllNotificationModel({this.message, this.object, this.success});

  GetAllNotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? postNotificationUid;
  String? subject;
  String? title;
  String? notificationMessage;
  String? receivedAt;
  String? senderUid;
  String? accessCode;
  String? image;
  bool? isSeen;

  Object(
      {this.postNotificationUid,
      this.subject,
      this.title,
      this.notificationMessage,
      this.receivedAt,
      this.senderUid,
      this.accessCode,
      this.image,
      this.isSeen});

  Object.fromJson(Map<String, dynamic> json) {
    postNotificationUid = json['postNotificationUid'];
    subject = json['subject'];
    title = json['title'];
    notificationMessage = json['notificationMessage'];
    receivedAt = json['receivedAt'];
    senderUid = json['senderUid'];
    accessCode = json['accessCode'];
    image = json['image'];
    isSeen = json['isSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postNotificationUid'] = this.postNotificationUid;
    data['subject'] = this.subject;
    data['title'] = this.title;
    data['notificationMessage'] = this.notificationMessage;
    data['receivedAt'] = this.receivedAt;
    data['senderUid'] = this.senderUid;
    data['accessCode'] = this.accessCode;
    data['image'] = this.image;
    data['isSeen'] = this.isSeen;
    return data;
  }
}
