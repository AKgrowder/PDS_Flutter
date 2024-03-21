class GetAdminRolesForCompanyPage {
  String? message;
  List<Object1>? object;
  bool? success;

  GetAdminRolesForCompanyPage({this.message, this.object, this.success});

  GetAdminRolesForCompanyPage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['object'] != null) {
      object = <Object1>[];
      json['object'].forEach((v) {
        object!.add(new Object1.fromJson(v));
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

class Object1 {
  String? adminRoleUid;
  String? adminRole;
  String? roleDescription;
  Object1({this.adminRoleUid, this.adminRole});

  Object1.fromJson(Map<String, dynamic> json) {
    adminRoleUid = json['adminRoleUid'];
    adminRole = json['adminRole'];
    roleDescription = json['roleDescription'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminRoleUid'] = this.adminRoleUid;
    data['adminRole'] = this.adminRole;
    return data;
  }
}
