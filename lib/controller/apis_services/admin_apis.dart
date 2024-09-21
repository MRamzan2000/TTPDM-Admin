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
  Future<void> updateRightsMidAdminApiMethod({
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
    final response = await http.patch(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      log("response body:${response.body}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Mid admin permissions updated")));
      }
      Get.back();
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${responseBody["message"]}")));
      }
      log("response :${response.body}");
      log("statusCode :${response.statusCode}");
    }
  }

  //Delete MidAdmin
  Future<void> deleteMidAdminMethodApi({
    required String id,
    required BuildContext context, // Add BuildContext to show ScaffoldMessenger
  }) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse('$baseUrl/$deleteMidAdminEp/$id');

    try {
      final response = await http.delete(url, headers: headers);

      // Log the response for debugging
      log('Response body: ${response.body}');
      log('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Show success message
     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Successfully deleted.')),
       );
     }
      } else {
        // Show failure message
       if(context.mounted){
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Failed to delete. Please try again.')),
         );
       }
      }
    } catch (e) {
      // Log and show error message
      log('Exception: $e');
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while deleting.')),
      );
    }
    }
  }

//Handle Mid Admin Request
  Future<void> handleBusinessManageRequest({
    required String requestId,
    required String status,
  }) async {
    final url = Uri.parse("$baseUrl/$midAdminRequestHandleEP");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "requestId": requestId,
      "action": status // or "reject"
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
   if(context.mounted){
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(responseBody["message"].toString())),
     );
   }
    } else {
      Map<String, dynamic> responseBody = json.decode(response.body);
      log(responseBody["message"].toString());
     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(responseBody["message"].toString())),
       );
     }
    }
  }
}
