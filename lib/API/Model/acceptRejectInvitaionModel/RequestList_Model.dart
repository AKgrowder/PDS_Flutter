class RequestListModel {
  String? message;
  List<Object>? object;
  bool? success;

  RequestListModel({this.message, this.object, this.success});

  RequestListModel.fromJson(Map<String, dynamic> json) {
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
  String? followedByUserName;
  String? followUuid;
  String? followedByUserProfilePic;
  String? followedByUserUid;
  String? followStatus;

  Object(
      {this.followedByUserName,
      this.followUuid,
      this.followedByUserProfilePic,
      this.followedByUserUid,
      this.followStatus});

  Object.fromJson(Map<String, dynamic> json) {
    followedByUserName = json['followedByUserName'];
    followUuid = json['followUuid'];
    followedByUserProfilePic = json['followedByUserProfilePic'];
    followedByUserUid = json['followedByUserUid'];
    followStatus = json['followStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followedByUserName'] = this.followedByUserName;
    data['followUuid'] = this.followUuid;
    data['followedByUserProfilePic'] = this.followedByUserProfilePic;
    data['followedByUserUid'] = this.followedByUserUid;
    data['followStatus'] = this.followStatus;
    return data;
  }
}
