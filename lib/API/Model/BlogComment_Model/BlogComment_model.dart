class BlogCommentModel {
  String? message;
  List<ObjectBlog>? object;
  bool? success;

  BlogCommentModel({this.message, this.object, this.success});

  BlogCommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['object'] != null) {
      object = <ObjectBlog>[];
      json['object'].forEach((v) {
        object!.add(new ObjectBlog.fromJson(v));
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

class ObjectBlog {
  String? blogUid;
  String? commentUid;
  String? userUid;
  String? comment;
  String? userProfilePic;
  String? userName;
  String? createdAt;

  ObjectBlog(
      {this.blogUid,
      this.commentUid,
      this.userUid,
      this.comment,
      this.userProfilePic,
      this.userName,
      this.createdAt});

  ObjectBlog.fromJson(Map<String, dynamic> json) {
    blogUid = json['blogUid'];
    commentUid = json['commentUid'];
    userUid = json['userUid'];
    comment = json['comment'];
    userProfilePic = json['userProfilePic'];
    userName = json['userName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogUid'] = this.blogUid;
    data['commentUid'] = this.commentUid;
    data['userUid'] = this.userUid;
    data['comment'] = this.comment;
    data['userProfilePic'] = this.userProfilePic;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
