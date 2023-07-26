class sendMSGModel {
  String? message;
  Object? object;
  bool? success;

  sendMSGModel({this.message, this.object, this.success});

  sendMSGModel.fromJson(Map<String, dynamic> json) {
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
  Null? id;
  String? createdAt;
  Null? createdBy;
  Null? status;
  Null? isActive;
  Null? uid;
  String? modifiedAt;
  Null? modifiedBy;
  Null? message;
  Null? messageType;

  Object(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.status,
      this.isActive,
      this.uid,
      this.modifiedAt,
      this.modifiedBy,
      this.message,
      this.messageType});

  Object.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    status = json['status'];
    isActive = json['isActive'];
    uid = json['uid'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    message = json['message'];
    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['isActive'] = this.isActive;
    data['uid'] = this.uid;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    return data;
  }
}
