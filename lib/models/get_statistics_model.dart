
import 'dart:convert';

List<GetStatisticsModel> getStatisticsModelFromJson(String str) => List<GetStatisticsModel>.from(json.decode(str).map((x) => GetStatisticsModel.fromJson(x)));

String getStatisticsModelToJson(List<GetStatisticsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStatisticsModel {
  int count;
  String plan;

  GetStatisticsModel({
    required this.count,
    required this.plan,
  });

  GetStatisticsModel copyWith({
    int? count,
    String? plan,
  }) =>
      GetStatisticsModel(
        count: count ?? this.count,
        plan: plan ?? this.plan,
      );

  factory GetStatisticsModel.fromJson(Map<String, dynamic> json) => GetStatisticsModel(
    count: json["count"],
    plan: json["plan"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "plan": plan,
  };
}
