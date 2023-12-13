class GetAllStoryModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetAllStoryModel({this.message, this.object, this.success});

  GetAllStoryModel.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? userUid;
  dynamic profilePic;
  List<StoryData>? storyData;

  Object({this.userName, this.userUid, this.profilePic, this.storyData});

  Object.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userUid = json['userUid'];
    profilePic = json['profilePic'];
    if (json['storyData'] != null) {
      storyData = <StoryData>[];
      json['storyData'].forEach((v) {
        storyData!.add(new StoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userUid'] = this.userUid;
    data['profilePic'] = this.profilePic;
    if (this.storyData != null) {
      data['storyData'] = this.storyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryData {
  String? storyUid;
  String? storyData;
  String? userUid;
  String? profilePic;
  String? userName;
  String? createdAt;
  bool? isLoggedIn;
  bool? storySeen;

  StoryData(
      {this.storyUid,
      this.storyData,
      this.userUid,
      this.profilePic,
      this.userName,
      this.createdAt,
      this.isLoggedIn,
      this.storySeen});

  StoryData.fromJson(Map<String, dynamic> json) {
    storyUid = json['storyUid'];
    storyData = json['storyData'];
    userUid = json['userUid'];
    profilePic = json['profilePic'];
    userName = json['userName'];
    createdAt = json['createdAt'];
    isLoggedIn = json['isLoggedIn'];
    storySeen = json['storySeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storyUid'] = this.storyUid;
    data['storyData'] = this.storyData;
    data['userUid'] = this.userUid;
    data['profilePic'] = this.profilePic;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    data['isLoggedIn'] = this.isLoggedIn;
    data['storySeen'] = this.storySeen;
    return data;
  }
}
