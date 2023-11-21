class GetUserPostCommetModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetUserPostCommetModel({this.message, this.object, this.success});

  GetUserPostCommetModel.fromJson(Map<String, dynamic> json) {
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
  String? postUid;
  String? createdAt;
  String? userUid;
  String? postUserName;
  String? userProfilePic;
  String? description;
  List<String>? postData;
  String? postDataType;
  String? postType;
  List<Comments>? comments;

  Object(
      {this.postUid,
      this.createdAt,
      this.userUid,
      this.postUserName,
      this.userProfilePic,
      this.description,
      this.postData,
      this.postDataType,
      this.postType,
      this.comments});

  Object.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    description = json['description'];
    postData = json['postData'].cast<String>();
    postDataType = json['postDataType'];
    postType = json['postType'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['createdAt'] = this.createdAt;
    data['userUid'] = this.userUid;
    data['postUserName'] = this.postUserName;
    data['userProfilePic'] = this.userProfilePic;
    data['description'] = this.description;
    data['postData'] = this.postData;
    data['postDataType'] = this.postDataType;
    data['postType'] = this.postType;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? commentUid;
  String? comment;
  String? profilePic;
  String? userName;
  String? createdAt;

  Comments(
      {this.commentUid,
      this.comment,
      this.profilePic,
      this.userName,
      this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
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
