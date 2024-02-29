class LiveStatusModel {
  String? message;
  Object? object;
  bool? success;

  LiveStatusModel({this.message, this.object, this.success});

  LiveStatusModel.fromJson(Map<String, dynamic> json) {
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
  bool? online;
  bool? live;
  bool? isBlock;

  Object({this.online, this.live, this.isBlock});

  Object.fromJson(Map<String, dynamic> json) {
    online = json['online'];
    live = json['live'];
    isBlock = json['isBlock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['online'] = this.online;
    data['live'] = this.live;
    data['isBlock'] = this.isBlock;
    return data;
  }
}
