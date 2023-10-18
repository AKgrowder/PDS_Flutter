class AddCommentModel {
  String? message;
  List<Object>? object;
  bool? success;

  AddCommentModel({this.message, this.object, this.success});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
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
