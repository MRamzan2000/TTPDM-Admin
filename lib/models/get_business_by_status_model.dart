
import 'dart:convert';

GetBusinessByStatusModel getBusinessByStatusModelFromJson(String str) => GetBusinessByStatusModel.fromJson(json.decode(str));

String getBusinessByStatusModelToJson(GetBusinessByStatusModel data) => json.encode(data.toJson());

class GetBusinessByStatusModel {
  List<Business> businesses;

  GetBusinessByStatusModel({
    required this.businesses,
  });

  GetBusinessByStatusModel copyWith({
    List<Business>? businesses,
  }) =>
      GetBusinessByStatusModel(
        businesses: businesses ?? this.businesses,
      );

  factory GetBusinessByStatusModel.fromJson(Map<String, dynamic> json) => GetBusinessByStatusModel(
    businesses: List<Business>.from(json["businesses"].map((x) => Business.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
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
  Owner owner;
  String status;
  String websiteUrl;
  String facebookUrl;
  String instagramUrl;
  String linkedinUrl;
  String tiktokUrl;
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
    Owner? owner,
    String? status,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    String? linkedinUrl,
    String? tiktokUrl,
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
    owner: Owner.fromJson(json["owner"]),
    status: json["status"],
    websiteUrl: json["websiteUrl"],
    facebookUrl: json["facebookUrl"],
    instagramUrl: json["instagramUrl"],
    linkedinUrl: json["linkedinUrl"],
    tiktokUrl: json["tiktokUrl"],
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
    "owner": owner.toJson(),
    "status": status,
    "websiteUrl": websiteUrl,
    "facebookUrl": facebookUrl,
    "instagramUrl": instagramUrl,
    "linkedinUrl": linkedinUrl,
    "tiktokUrl": tiktokUrl,
    "__v": v,
  };
}

class Owner {
  String id;
  String email;

  Owner({
    required this.id,
    required this.email,
  });

  Owner copyWith({
    String? id,
    String? email,
  }) =>
      Owner(
        id: id ?? this.id,
        email: email ?? this.email,
      );

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["_id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
  };
}
