import 'dart:developer';

class CreateStoryModel {
  String? message;
  String? object;
  bool? success;

  CreateStoryModel({this.message, this.object, this.success});

  CreateStoryModel.fromJson(Map<String, dynamic> json) {
    log('message-$json');
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
