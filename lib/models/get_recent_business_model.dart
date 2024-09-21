
import 'dart:convert';

List<GetRecentBusinessModel> getRecentBusinessModelFromJson(String str) => List<GetRecentBusinessModel>.from(json.decode(str).map((x) => GetRecentBusinessModel.fromJson(x)));

String getRecentBusinessModelToJson(List<GetRecentBusinessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetRecentBusinessModel {
  String id;
  String name;
  String phone;
  String location;
  String targetMapArea;
  String description;
  List<dynamic> gallery;
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

  GetRecentBusinessModel({
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

  GetRecentBusinessModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? location,
    String? targetMapArea,
    String? description,
    List<dynamic>? gallery,
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
      GetRecentBusinessModel(
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

  factory GetRecentBusinessModel.fromJson(Map<String, dynamic> json) => GetRecentBusinessModel(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    targetMapArea: json["targetMapArea"],
    description: json["description"],
    gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
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
