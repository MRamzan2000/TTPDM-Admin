
import 'dart:convert';

List<GetAllDesignRequestModel> getAllDesignRequestModelFromJson(String str) => List<GetAllDesignRequestModel>.from(json.decode(str).map((x) => GetAllDesignRequestModel.fromJson(x)));

String getAllDesignRequestModelToJson(List<GetAllDesignRequestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllDesignRequestModel {
  String id;
  User user;
  String description;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetAllDesignRequestModel({
    required this.id,
    required this.user,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  GetAllDesignRequestModel copyWith({
    String? id,
    User? user,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      GetAllDesignRequestModel(
        id: id ?? this.id,
        user: user ?? this.user,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory GetAllDesignRequestModel.fromJson(Map<String, dynamic> json) => GetAllDesignRequestModel(
    id: json["_id"],
    user: User.fromJson(json["user"]),
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user.toJson(),
    "description": description,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class User {
  String id;
  String fullname;
  String email;

  User({
    required this.id,
    required this.fullname,
    required this.email,
  });

  User copyWith({
    String? id,
    String? fullname,
    String? email,
  }) =>
      User(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    fullname: json["fullname"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "email": email,
  };
}
