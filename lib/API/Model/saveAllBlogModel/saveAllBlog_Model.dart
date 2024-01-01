class saveAllBlogModel {
  String? message;
  List<Object>? object;
  bool? success;

  saveAllBlogModel({this.message, this.object, this.success});

  saveAllBlogModel.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  String? createrName;
  String? title;
  String? image;
  String? description;
  String? modifiedAt;
  String? createdAt;
  bool? isSaved;
  bool? isLiked;
  int? likeCount;
  int? commentCount;

  Object(
      {this.uid,
      this.createrName,
      this.title,
      this.image,
      this.description,
      this.modifiedAt,
      this.createdAt,
      this.isSaved,
      this.likeCount,
      this.commentCount,
      this.isLiked});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    createrName = json['createrName'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    modifiedAt = json['modifiedAt'];
    createdAt = json['createdAt'];
    isSaved = json['isSaved'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['createrName'] = this.createrName;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['modifiedAt'] = this.modifiedAt;
    data['createdAt'] = this.createdAt;
    data['isSaved'] = this.isSaved;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    data['isLiked'] = this.isLiked;
    return data;
  }
}
