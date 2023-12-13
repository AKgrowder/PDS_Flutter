class GetWorkExperienceModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetWorkExperienceModel({this.message, this.object, this.success});

  GetWorkExperienceModel.fromJson(Map<String, dynamic> json) {
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
  String? workExperienceUid;
  String? userProfilePic;
  String? companyName;
  String? jobProfile;
  String? industryType;
  String? expertiseIn;
  String? startDate;
  String? endDate;

  Object(
      {this.workExperienceUid,
      this.userProfilePic,
      this.companyName,
      this.jobProfile,
      this.industryType,
      this.expertiseIn,
      this.startDate,
      this.endDate});

  Object.fromJson(Map<String, dynamic> json) {
    workExperienceUid = json['workExperienceUid'];
    userProfilePic = json['userProfilePic'];
    companyName = json['companyName'];
    jobProfile = json['jobProfile'];
    industryType = json['industryType'];
    expertiseIn = json['expertiseIn'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workExperienceUid'] = this.workExperienceUid;
    data['userProfilePic'] = this.userProfilePic;
    data['companyName'] = this.companyName;
    data['jobProfile'] = this.jobProfile;
    data['industryType'] = this.industryType;
    data['expertiseIn'] = this.expertiseIn;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
