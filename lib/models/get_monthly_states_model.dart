
import 'dart:convert';

GetAllStatesModel getAllStatesModelFromJson(String str) => GetAllStatesModel.fromJson(json.decode(str));

String getAllStatesModelToJson(GetAllStatesModel data) => json.encode(data.toJson());

class GetAllStatesModel {
  Cancellations totalUsers;
  Campaigns campaigns;
  Cancellations cancellations;
  Cancellations returnRate;

  GetAllStatesModel({
    required this.totalUsers,
    required this.campaigns,
    required this.cancellations,
    required this.returnRate,
  });

  GetAllStatesModel copyWith({
    Cancellations? totalUsers,
    Campaigns? campaigns,
    Cancellations? cancellations,
    Cancellations? returnRate,
  }) =>
      GetAllStatesModel(
        totalUsers: totalUsers ?? this.totalUsers,
        campaigns: campaigns ?? this.campaigns,
        cancellations: cancellations ?? this.cancellations,
        returnRate: returnRate ?? this.returnRate,
      );

  factory GetAllStatesModel.fromJson(Map<String, dynamic> json) => GetAllStatesModel(
    totalUsers: Cancellations.fromJson(json["totalUsers"]),
    campaigns: Campaigns.fromJson(json["campaigns"]),
    cancellations: Cancellations.fromJson(json["cancellations"]),
    returnRate: Cancellations.fromJson(json["returnRate"]),
  );

  Map<String, dynamic> toJson() => {
    "totalUsers": totalUsers.toJson(),
    "campaigns": campaigns.toJson(),
    "cancellations": cancellations.toJson(),
    "returnRate": returnRate.toJson(),
  };
}

class Campaigns {
  Cancellations created;

  Campaigns({
    required this.created,
  });

  Campaigns copyWith({
    Cancellations? created,
  }) =>
      Campaigns(
        created: created ?? this.created,
      );

  factory Campaigns.fromJson(Map<String, dynamic> json) => Campaigns(
    created: Cancellations.fromJson(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "created": created.toJson(),
  };
}

class Cancellations {
  double thisMonth;
  double lastMonth;

  Cancellations({
    required this.thisMonth,
    required this.lastMonth,
  });

  Cancellations copyWith({
    double? thisMonth,
    double? lastMonth,
  }) =>
      Cancellations(
        thisMonth: thisMonth ?? this.thisMonth,
        lastMonth: lastMonth ?? this.lastMonth,
      );

  factory Cancellations.fromJson(Map<String, dynamic> json) => Cancellations(
    thisMonth: (json["thisMonth"] as num).toDouble(),
    lastMonth: (json["lastMonth"] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "thisMonth": thisMonth,
    "lastMonth": lastMonth,
  };
}
