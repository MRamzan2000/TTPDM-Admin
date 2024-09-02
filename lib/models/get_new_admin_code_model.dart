
import 'dart:convert';

GetNewAdminCodeModel getNewAdminCodeModelFromJson(String str) => GetNewAdminCodeModel.fromJson(json.decode(str));

String getNewAdminCodeModelToJson(GetNewAdminCodeModel data) => json.encode(data.toJson());

class GetNewAdminCodeModel {
  String message;
  AdminCode adminCode;

  GetNewAdminCodeModel({
    required this.message,
    required this.adminCode,
  });

  GetNewAdminCodeModel copyWith({
    String? message,
    AdminCode? adminCode,
  }) =>
      GetNewAdminCodeModel(
        message: message ?? this.message,
        adminCode: adminCode ?? this.adminCode,
      );

  factory GetNewAdminCodeModel.fromJson(Map<String, dynamic> json) => GetNewAdminCodeModel(
    message: json["message"],
    adminCode: AdminCode.fromJson(json["adminCode"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "adminCode": adminCode.toJson(),
  };
}

class AdminCode {
  String code;
  String createdBy;
  String id;
  DateTime createdAt;

  AdminCode({
    required this.code,
    required this.createdBy,
    required this.id,
    required this.createdAt,
  });

  AdminCode copyWith({
    String? code,
    String? createdBy,
    String? id,
    DateTime? createdAt,
  }) =>
      AdminCode(
        code: code ?? this.code,
        createdBy: createdBy ?? this.createdBy,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory AdminCode.fromJson(Map<String, dynamic> json) => AdminCode(
    code: json["code"],
    createdBy: json["createdBy"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "createdBy": createdBy,
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
  };
}
