class AddnewCommentsModel {
  String? message;
  Object? object;
  bool? success;

  AddnewCommentsModel({this.message, this.object, this.success});

  AddnewCommentsModel.fromJson(Map<String, dynamic> json) {
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
  String? commentUid;
  String? comment;
  String? profilePic;
  String? userName;
  String? createdAt;

  Object(
      {this.commentUid,
      this.comment,
      this.profilePic,
      this.userName,
      this.createdAt});

  Object.fromJson(Map<String, dynamic> json) {
    commentUid = json['commentUid'];
    comment = json['comment'];
    profilePic = json['profilePic'];
    userName = json['userName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentUid'] = this.commentUid;
    data['comment'] = this.comment;
    data['profilePic'] = this.profilePic;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
