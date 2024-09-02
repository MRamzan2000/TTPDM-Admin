
import 'dart:convert';

GetUserProfileModel getUserProfileModelFromJson(String str) => GetUserProfileModel.fromJson(json.decode(str));

String getUserProfileModelToJson(GetUserProfileModel data) => json.encode(data.toJson());

class GetUserProfileModel {
  Subscription subscription;
  Permissions permissions;
  String id;
  String fullname;
  String email;
  String address;
  String phoneNumber;
  String confirmPassword;
  String role;
  List<dynamic> businesses;
  int v;
  int coinBalance;
  String fcmToken;
  String profilePic;

  GetUserProfileModel({
    required this.subscription,
    required this.permissions,
    required this.id,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.confirmPassword,
    required this.role,
    required this.businesses,
    required this.v,
    required this.coinBalance,
    required this.fcmToken,
    required this.profilePic,
  });

  GetUserProfileModel copyWith({
    Subscription? subscription,
    Permissions? permissions,
    String? id,
    String? fullname,
    String? email,
    String? address,
    String? phoneNumber,
    String? confirmPassword,
    String? role,
    List<dynamic>? businesses,
    int? v,
    int? coinBalance,
    String? fcmToken,
    String? profilePic,
  }) =>
      GetUserProfileModel(
        subscription: subscription ?? this.subscription,
        permissions: permissions ?? this.permissions,
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        role: role ?? this.role,
        businesses: businesses ?? this.businesses,
        v: v ?? this.v,
        coinBalance: coinBalance ?? this.coinBalance,
        fcmToken: fcmToken ?? this.fcmToken,
        profilePic: profilePic ?? this.profilePic,
      );

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) => GetUserProfileModel(
    subscription: Subscription.fromJson(json["subscription"]),
    permissions: Permissions.fromJson(json["permissions"]),
    id: json["_id"],
    fullname: json["fullname"],
    email: json["email"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    confirmPassword: json["confirmPassword"],
    role: json["role"],
    businesses: List<dynamic>.from(json["businesses"].map((x) => x)),
    v: json["__v"],
    coinBalance: json["coinBalance"],
    fcmToken: json["fcmToken"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "subscription": subscription.toJson(),
    "permissions": permissions.toJson(),
    "_id": id,
    "fullname": fullname,
    "email": email,
    "address": address,
    "phoneNumber": phoneNumber,
    "confirmPassword": confirmPassword,
    "role": role,
    "businesses": List<dynamic>.from(businesses.map((x) => x)),
    "__v": v,
    "coinBalance": coinBalance,
    "fcmToken": fcmToken,
    "profilePic": profilePic,
  };
}

class Permissions {
  AdBannerDesigns campaigns;
  AdBannerDesigns businesses;
  AdBannerDesigns adBannerDesigns;

  Permissions({
    required this.campaigns,
    required this.businesses,
    required this.adBannerDesigns,
  });

  Permissions copyWith({
    AdBannerDesigns? campaigns,
    AdBannerDesigns? businesses,
    AdBannerDesigns? adBannerDesigns,
  }) =>
      Permissions(
        campaigns: campaigns ?? this.campaigns,
        businesses: businesses ?? this.businesses,
        adBannerDesigns: adBannerDesigns ?? this.adBannerDesigns,
      );

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
    campaigns: AdBannerDesigns.fromJson(json["campaigns"]),
    businesses: AdBannerDesigns.fromJson(json["businesses"]),
    adBannerDesigns: AdBannerDesigns.fromJson(json["adBannerDesigns"]),
  );

  Map<String, dynamic> toJson() => {
    "campaigns": campaigns.toJson(),
    "businesses": businesses.toJson(),
    "adBannerDesigns": adBannerDesigns.toJson(),
  };
}

class AdBannerDesigns {
  bool manage;

  AdBannerDesigns({
    required this.manage,
  });

  AdBannerDesigns copyWith({
    bool? manage,
  }) =>
      AdBannerDesigns(
        manage: manage ?? this.manage,
      );

  factory AdBannerDesigns.fromJson(Map<String, dynamic> json) => AdBannerDesigns(
    manage: json["manage"],
  );

  Map<String, dynamic> toJson() => {
    "manage": manage,
  };
}

class Subscription {
  String plan;
  dynamic startDate;

  Subscription({
    required this.plan,
    required this.startDate,
  });

  Subscription copyWith({
    String? plan,
    dynamic startDate,
  }) =>
      Subscription(
        plan: plan ?? this.plan,
        startDate: startDate ?? this.startDate,
      );

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    plan: json["plan"],
    startDate: json["startDate"],
  );

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "startDate": startDate??"",
  };
}
