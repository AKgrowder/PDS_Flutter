class CreateForm {
  String? message;
  Object? object;
  bool? success;

  CreateForm({this.message, this.object, this.success});

  CreateForm.fromJson(Map<String, dynamic> json) {
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
  String? forumName;
  Null? forumDetails;
  Null? user;

  Object({this.uid, this.forumName, this.forumDetails, this.user});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    forumName = json['forumName'];
    forumDetails = json['forumDetails'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['forumName'] = this.forumName;
    data['forumDetails'] = this.forumDetails;
    data['user'] = this.user;
    return data;
  }
}