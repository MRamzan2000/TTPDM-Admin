
import 'dart:convert';

List<GetUsersModel> getUsersModelFromJson(String str) => List<GetUsersModel>.from(json.decode(str).map((x) => GetUsersModel.fromJson(x)));

String getUsersModelToJson(List<GetUsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsersModel {
  String email;
  SubscriptionPlan subscriptionPlan;

  GetUsersModel({
    required this.email,
    required this.subscriptionPlan,
  });

  GetUsersModel copyWith({
    String? email,
    SubscriptionPlan? subscriptionPlan,
  }) =>
      GetUsersModel(
        email: email ?? this.email,
        subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      );

  factory GetUsersModel.fromJson(Map<String, dynamic> json) => GetUsersModel(
    email: json["email"],
    subscriptionPlan: subscriptionPlanValues.map[json["subscriptionPlan"]]!,
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "subscriptionPlan": subscriptionPlanValues.reverse[subscriptionPlan],
  };
}

enum SubscriptionPlan {
  BASIC,
  NO_SUBSCRIPTION,
  PRO
}

final subscriptionPlanValues = EnumValues({
  "basic": SubscriptionPlan.BASIC,
  "No subscription": SubscriptionPlan.NO_SUBSCRIPTION,
  "pro": SubscriptionPlan.PRO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
