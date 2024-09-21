
import 'dart:convert';

GetBusinessManageRequestModel getBusinessManageRequestModelFromJson(String str) => GetBusinessManageRequestModel.fromJson(json.decode(str));

String getBusinessManageRequestModelToJson(GetBusinessManageRequestModel data) => json.encode(data.toJson());

class GetBusinessManageRequestModel {
  List<Request> requests;

  GetBusinessManageRequestModel({
    required this.requests,
  });

  GetBusinessManageRequestModel copyWith({
    List<Request>? requests,
  }) =>
      GetBusinessManageRequestModel(
        requests: requests ?? this.requests,
      );

  factory GetBusinessManageRequestModel.fromJson(Map<String, dynamic> json) => GetBusinessManageRequestModel(
    requests: List<Request>.from(json["requests"].map((x) => Request.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
  };
}

class Request {
  String id;
  MidAdmin midAdmin;
  Business business;
  String status;
  DateTime createdAt;
  int v;

  Request({
    required this.id,
    required this.midAdmin,
    required this.business,
    required this.status,
    required this.createdAt,
    required this.v,
  });

  Request copyWith({
    String? id,
    MidAdmin? midAdmin,
    Business? business,
    String? status,
    DateTime? createdAt,
    int? v,
  }) =>
      Request(
        id: id ?? this.id,
        midAdmin: midAdmin ?? this.midAdmin,
        business: business ?? this.business,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["_id"],
    midAdmin: MidAdmin.fromJson(json["midAdmin"]),
    business: Business.fromJson(json["business"]),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "midAdmin": midAdmin.toJson(),
    "business": business.toJson(),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
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

class MidAdmin {
  String id;
  String fullname;
  String email;

  MidAdmin({
    required this.id,
    required this.fullname,
    required this.email,
  });

  MidAdmin copyWith({
    String? id,
    String? fullname,
    String? email,
  }) =>
      MidAdmin(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
      );

  factory MidAdmin.fromJson(Map<String, dynamic> json) => MidAdmin(
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
