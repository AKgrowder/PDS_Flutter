class DeleteWorkExperienceModel {
  String? message;
  String? object;
  bool? success;

  DeleteWorkExperienceModel({this.message, this.object, this.success});

  DeleteWorkExperienceModel.fromJson(Map<String, dynamic> json) {
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
