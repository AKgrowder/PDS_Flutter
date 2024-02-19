class ImageDataPost {
  String? message;
  Object? object;
  bool? success;

  ImageDataPost({this.message, this.object, this.success});

  ImageDataPost.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Object {
  String? status;
  String? thumbnailImageUrl;
  List<String>? data;

  Object({this.status, this.thumbnailImageUrl, this.data});

  Object.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    thumbnailImageUrl = json['thumbnailImageUrl'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['data'] = this.data;
    return data;
  }
}
