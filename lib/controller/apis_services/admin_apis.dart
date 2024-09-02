import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm_admin/models/get_all_mid_admins_model.dart';
import 'package:ttpdm_admin/models/get_new_admin_code_model.dart';

class AdminApis {
  final BuildContext context;
  AdminApis({required this.context});
  //get All Mid Admins
  Future<List<GetAllMidAdminsModel>?> getAllMidAdminsApiMethod() async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl/$getAllMidAdminEp");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      log("response body:${response.body}");
      return getAllMidAdminsModelFromJson(response.body);
    }
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }

  //get New Admin Code
  Future<GetNewAdminCodeModel?> getNewAdminCodeApiMethod(
      {required String token}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse("$baseUrl/$newAdminCodeEp");
    final response = await http.get(url, headers: headers);
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    if (response.statusCode == 200) {
      return getNewAdminCodeModelFromJson(response.body);
    }
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }

  //get update rights mid Admin
  Future<void> updateRightsMidAdminApiMethod(
      {
        required String adminId,
        required bool campaignPermission,
        required bool designAdPermission,
        required bool businessesPermission,
      }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl/$changeRightsMidAdminEp/$adminId");
    final body = jsonEncode({
      "permissions": {
        "campaigns": {"manage": campaignPermission},
        "businesses": {"manage": businessesPermission},
        "adBannerDesigns": {"manage": designAdPermission}
      }
    });
    final response = await http.patch(url, headers: headers,body: body);
    if (response.statusCode == 200) {
      log("response body:${response.body}");
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mid admin permissions updated")));
      }
      Get.back();
    }else{
      Map<String,dynamic>responseBody=jsonDecode(response.body);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${responseBody["message"]}")));
      }
      log("response :${response.body}");
      log("statusCode :${response.statusCode}");
    }

  }
}
