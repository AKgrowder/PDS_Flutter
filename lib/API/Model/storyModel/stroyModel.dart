import 'dart:developer';

class ImageDataPostOne {
  String? message;
  String? object;
  bool? success;
  int? videodurationGet; 
  ImageDataPostOne({this.message, this.object, this.success,this.videodurationGet});

  ImageDataPostOne.fromJson(Map<String, dynamic> json) {
    log("messagecheck-$json");
    message = json['message'];
    object = json['object'];
    success = json['success'];
    videodurationGet = json['videodurationGet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['object'] = this.object;
    data['success'] = this.success;
    return data;
  }
}