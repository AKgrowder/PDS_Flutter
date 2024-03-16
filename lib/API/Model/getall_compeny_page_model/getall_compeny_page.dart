class GetAllCompenyPageModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetAllCompenyPageModel({this.message, this.object, this.success});

  GetAllCompenyPageModel.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  String? pageId;
  String? profilePic;
  String? companyType;
  String? description;
  String? pageUid;

  Object(
      {this.companyName,
      this.pageId,
      this.profilePic,
      this.companyType,
      this.description,
      this.pageUid});

  Object.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    pageId = json['pageId'];
    profilePic = json['profilePic'];
    companyType = json['companyType'];
    description = json['description'];
    pageUid = json['pageUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['pageId'] = this.pageId;
    data['profilePic'] = this.profilePic;
    data['companyType'] = this.companyType;
    data['description'] = this.description;
    data['pageUid'] = this.pageUid;
    return data;
  }
}
