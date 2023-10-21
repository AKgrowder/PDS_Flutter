class IndustryTypeModel {
  String? message;
  List<Object>? object;
  bool? success;

  IndustryTypeModel({this.message, this.object, this.success});

  IndustryTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? industryTypeUid;
  String? industryTypeName;

  Object({this.industryTypeUid, this.industryTypeName});

  Object.fromJson(Map<String, dynamic> json) {
    industryTypeUid = json['industryTypeUid'];
    industryTypeName = json['industryTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryTypeUid'] = this.industryTypeUid;
    data['industryTypeName'] = this.industryTypeName;
    return data;
  }
}
