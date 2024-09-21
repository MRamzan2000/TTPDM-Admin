
import 'dart:convert';

GetStatisticsModel getStatisticsModelFromJson(String str) => GetStatisticsModel.fromJson(json.decode(str));

String getStatisticsModelToJson(GetStatisticsModel data) => json.encode(data.toJson());

class GetStatisticsModel {
  int users;
  List<Plan> plans;

  GetStatisticsModel({
    required this.users,
    required this.plans,
  });

  GetStatisticsModel copyWith({
    int? users,
    List<Plan>? plans,
  }) =>
      GetStatisticsModel(
        users: users ?? this.users,
        plans: plans ?? this.plans,
      );

  factory GetStatisticsModel.fromJson(Map<String, dynamic> json) => GetStatisticsModel(
    users: json["users"],
    plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": users,
    "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
  };
}

class Plan {
  String plan;
  int count;

  Plan({
    required this.plan,
    required this.count,
  });

  Plan copyWith({
    String? plan,
    int? count,
  }) =>
      Plan(
        plan: plan ?? this.plan,
        count: count ?? this.count,
      );

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    plan: json["plan"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "count": count,
  };
}
