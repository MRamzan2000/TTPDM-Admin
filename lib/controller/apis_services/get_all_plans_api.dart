import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_all_plans_model.dart';
import 'package:http/http.dart' as http;

class GetAllPlansApi {
  final BuildContext context;
  GetAllPlansApi({required this.context});
  //Get All Plans Api Methods
  Future<List<GetAllPlansModel>?> getAllPlans() async {
    final url = Uri.parse("$baseUrl/$getAllSubPlanEP");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(headers: headers, url);
      if (response.statusCode == 200) {
        log("response :${response.body}");
        return getAllPlansModelFromJson(response.body);
      }
      log("response body :${response.body}");
      return null;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred :${e.toString()}")));
      }
    }
    return null;
  }

//Create New Plane
  Future<void> createNewSubPlan({
    required name,
    required price,
    required businessLimit,
  }) async {
    final url = Uri.parse("$baseUrl/$addNewSubPlanEP");
    final headers = {
      "Content-Type": 'application/json',
    };
    final body = jsonEncode({
      "name": name,
      "price": price,
      "businessLimit": businessLimit,
    });
    final response = await http.post(headers: headers, url, body: body);
    if (response.statusCode == 201) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add New SubPlan Successfully")));
      }
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${responseBody["message"]}")));
      }
    }
  }

  //update coins plan
  Future<void> updateSubPlanApiMethod({
    required token,
    required name,
    required price,
    required businessLimit,
    required subPlanId,
  }) async {
    final url = Uri.parse("$baseUrl/$updateSubPlanEP/$subPlanId");
    final headers = {
      "Content-Type": 'application/json',
      "Authorization": 'Bearer $token',
    };
    final body = jsonEncode({
      "name": name,
      "price": price,
      "businessLimit": businessLimit,
    });
    final response = await http.put(headers: headers, url, body: body);
    log("statusCode :${response.statusCode}");
    log("body :${response.body}");
    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Subscription plan updated successfully")));
      }
      Get.back();
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${responseBody["message"]}")));
      }
    }
  }

// //Delete Coins Plan
//   Future<void> deleteCoinsPlanApiMethod({
//     required subPlanPlanId,
//   }) async {
//     final url = Uri.parse("$baseUrl/$deleteSubPlanEP/$subPlanPlanId");
//     final headers = {
//       "Content-Type": 'application/json',
//     };
//     final response = await http.delete(
//       headers: headers,
//       url,
//     );
//     if (response.statusCode == 200) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Subscription plan deleted successfully")));
//       }
//     } else {
//       Map<String, dynamic> responseBody = jsonDecode(response.body);
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("${responseBody["message"]}")));
//       }
//     }
//   }
}
