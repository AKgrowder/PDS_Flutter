class getAllNotificationCount {
  String? message;
  Object? object;
  bool? success;

  getAllNotificationCount({this.message, this.object, this.success});

  getAllNotificationCount.fromJson(Map<String, dynamic> json) {
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
  int? notificationCount;
  int? messageCount;

  Object({this.notificationCount, this.messageCount});

  Object.fromJson(Map<String, dynamic> json) {
    notificationCount = json['notificationCount'];
    messageCount = json['messageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationCount'] = this.notificationCount;
    data['messageCount'] = this.messageCount;
    return data;
  }
}
