class RateUsModel {
  String? message;
  Object? object;
  bool? success;

  RateUsModel({this.message, this.object, this.success});

  RateUsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  double? star;
  String? dateOfRating;
  String? description;

  Object(
      {this.id, this.userId, this.star, this.dateOfRating, this.description});

  Object.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    star = json['star'];
    dateOfRating = json['dateOfRating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['star'] = this.star;
    data['dateOfRating'] = this.dateOfRating;
    data['description'] = this.description;
    return data;
  }
}
