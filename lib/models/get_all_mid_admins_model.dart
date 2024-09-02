
import 'dart:convert';

List<GetAllMidAdminsModel> getAllMidAdminsModelFromJson(String str) => List<GetAllMidAdminsModel>.from(json.decode(str).map((x) => GetAllMidAdminsModel.fromJson(x)));

String getAllMidAdminsModelToJson(List<GetAllMidAdminsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllMidAdminsModel {
  String id;
  String fullname;

  GetAllMidAdminsModel({
    required this.id,
    required this.fullname,
  });

  GetAllMidAdminsModel copyWith({
    String? id,
    String? fullname,
  }) =>
      GetAllMidAdminsModel(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
      );

  factory GetAllMidAdminsModel.fromJson(Map<String, dynamic> json) => GetAllMidAdminsModel(
    id: json["_id"],
    fullname: json["fullname"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
  };
}
