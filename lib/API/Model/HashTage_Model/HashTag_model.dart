class HashtagModel {
  String? message;
  List<Object>? object;
  bool? success;

  HashtagModel({this.message, this.object, this.success});

  HashtagModel.fromJson(Map<String, dynamic> json) {
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
  String? hashtagName;
  int? postCount;

  Object({this.hashtagName, this.postCount});

  Object.fromJson(Map<String, dynamic> json) {
    hashtagName = json['hashtagName'];
    postCount = json['postCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hashtagName'] = this.hashtagName;
    data['postCount'] = this.postCount;
    return data;
  }
}
