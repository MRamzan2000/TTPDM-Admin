
import 'dart:convert';

List<GetAllDesignRequestModel> getAllDesignRequestModelFromJson(String str) => List<GetAllDesignRequestModel>.from(json.decode(str).map((x) => GetAllDesignRequestModel.fromJson(x)));

String getAllDesignRequestModelToJson(List<GetAllDesignRequestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllDesignRequestModel {
  String id;
  User user;
  String description;
  Business business;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetAllDesignRequestModel({
    required this.id,
    required this.user,
    required this.description,
    required this.business,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  GetAllDesignRequestModel copyWith({
    String? id,
    User? user,
    String? description,
    Business? business,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      GetAllDesignRequestModel(
        id: id ?? this.id,
        user: user ?? this.user,
        description: description ?? this.description,
        business: business ?? this.business,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory GetAllDesignRequestModel.fromJson(Map<String, dynamic> json) => GetAllDesignRequestModel(
    id: json["_id"],
    user: User.fromJson(json["user"]),
    description: json["description"],
    business: Business.fromJson(json["business"]),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user.toJson(),
    "description": description,
    "business": business.toJson(),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Business {
  String id;
  String name;
  String phone;
  String location;
  String targetMapArea;
  String description;
  List<String> gallery;
  String logo;
  String owner;
  String status;
  String websiteUrl;
  String facebookUrl;
  String instagramUrl;
  String linkedinUrl;
  String tiktokUrl;
  DateTime createdAt;
  int v;

  Business({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.targetMapArea,
    required this.description,
    required this.gallery,
    required this.logo,
    required this.owner,
    required this.status,
    required this.websiteUrl,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.linkedinUrl,
    required this.tiktokUrl,
    required this.createdAt,
    required this.v,
  });

  Business copyWith({
    String? id,
    String? name,
    String? phone,
    String? location,
    String? targetMapArea,
    String? description,
    List<String>? gallery,
    String? logo,
    String? owner,
    String? status,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    String? linkedinUrl,
    String? tiktokUrl,
    DateTime? createdAt,
    int? v,
  }) =>
      Business(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        location: location ?? this.location,
        targetMapArea: targetMapArea ?? this.targetMapArea,
        description: description ?? this.description,
        gallery: gallery ?? this.gallery,
        logo: logo ?? this.logo,
        owner: owner ?? this.owner,
        status: status ?? this.status,
        websiteUrl: websiteUrl ?? this.websiteUrl,
        facebookUrl: facebookUrl ?? this.facebookUrl,
        instagramUrl: instagramUrl ?? this.instagramUrl,
        linkedinUrl: linkedinUrl ?? this.linkedinUrl,
        tiktokUrl: tiktokUrl ?? this.tiktokUrl,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    targetMapArea: json["targetMapArea"],
    description: json["description"],
    gallery: List<String>.from(json["gallery"].map((x) => x)),
    logo: json["logo"],
    owner: json["owner"],
    status: json["status"],
    websiteUrl: json["websiteUrl"],
    facebookUrl: json["facebookUrl"],
    instagramUrl: json["instagramUrl"],
    linkedinUrl: json["linkedinUrl"],
    tiktokUrl: json["tiktokUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "location": location,
    "targetMapArea": targetMapArea,
    "description": description,
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "logo": logo,
    "owner": owner,
    "status": status,
    "websiteUrl": websiteUrl,
    "facebookUrl": facebookUrl,
    "instagramUrl": instagramUrl,
    "linkedinUrl": linkedinUrl,
    "tiktokUrl": tiktokUrl,
    "createdAt": createdAt.toIso8601String(),
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
