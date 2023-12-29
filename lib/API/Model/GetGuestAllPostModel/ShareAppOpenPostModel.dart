class ShareAppOpenPostModel {
  String? message;
  Object? object;
  bool? success;

  ShareAppOpenPostModel({this.message, this.object, this.success});

  ShareAppOpenPostModel.fromJson(Map<String, dynamic> json) {
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
  String? postUid;
  String? userUid;

  Object({this.postUid, this.userUid});

  Object.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    userUid = json['userUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['userUid'] = this.userUid;
    return data;
  }
}
