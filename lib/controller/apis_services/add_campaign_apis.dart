import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_canpaign_by_status_model.dart';
import 'package:http/http.dart' as http;
class AddCampaignApis {
  final BuildContext context;
  AddCampaignApis({required this.context});
  //getCampaignByStatus
  Future<GetCampaignsByStatusModel?> getCampaignByStatus(
      {required String status}) async {
    final url = Uri.parse("$baseUrl/$getCampaignByStatusEp/$status");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);

      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        log('fetching campaign by status: ${response.body}');
        return getCampaignsByStatusModelFromJson(response.body);
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }

  //Change Campaign Status
  Future<void> changeCampaignStatusApi({
    required String token,
    required String campaignId,
    required String status,
    required String rejectionReason,
  }) async {
    final url = Uri.parse("$baseUrl/$changeCampaignStatus");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final body = jsonEncode({
      "campaignId": campaignId,
      "status": status,
      "rejectionReason": rejectionReason,
    });
    final response = await http.patch(headers: headers, url, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseBody["message"])));
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

  //Add Analysis
  Future<void> addAnalysisApi({
    required String campaignId,
    required String date,
    required String impressions,
    required String clicks,
  }) async {
    final url = Uri.parse("$baseUrl/$addAnalysisEp$campaignId/analytics");
    final headers = {
      "Content-Type": "application/json",
    };
    final body = jsonEncode(
        {"date": date, "impressions": impressions, "clicks": clicks});
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseBody["message"])));
      }
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseBody["message"])));
      }
    }
  }
}
