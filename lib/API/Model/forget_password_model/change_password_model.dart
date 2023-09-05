class ChangePasswordModel {
  String? message;
  bool? object;
  bool? success;

  ChangePasswordModel({this.message, this.object, this.success});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object = json['object'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['object'] = this.object;
    data['success'] = this.success;
    return data;
  }
}
class ChangePasswordModelSectionPasswordChages{
  String? message;
  bool? object;
  bool? success;

  ChangePasswordModelSectionPasswordChages({this.message, this.object, this.success});

  ChangePasswordModelSectionPasswordChages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object = json['object'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['object'] = this.object;
    data['success'] = this.success;
    return data;
  }
}
