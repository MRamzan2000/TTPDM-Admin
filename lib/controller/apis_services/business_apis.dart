import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_all_businesses_model.dart';
import 'package:ttpdm_admin/models/get_business_by_status_model.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm_admin/models/get_business_manage_request_model.dart';
import 'package:ttpdm_admin/models/get_recent_business_model.dart';

class BusinessApis {
  final BuildContext context;
  BusinessApis({required this.context});
  Future<GetBusinessByStatusModel?> getBusinessByStatus(
      {required BuildContext context, required status}) async {
    final url = Uri.parse("$baseUrl/$getBusinessByStatusEp/$status");
    log("url :$url");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");

      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return GetBusinessByStatusModel.fromJson(jsonDecode(response.body));
      } else {
        log('Error fetching business: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business: ${e.toString()}');
      return null;
    }
  }

  //Get All Business
  Future<GetAllBusinessModel?> getAllBusiness({
    required BuildContext context,
  }) async {
    final url = Uri.parse("$baseUrl/$getAllBusinessEp");
    log("url :$url");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");

      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return getAllBusinessModelFromJson(jsonDecode(response.body));
      } else {
        log('Error fetching businesses: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching businesses: ${e.toString()}');
      return null;
    }
  }

  //Get Business Manage Request Api
  Future<GetBusinessManageRequestModel?>
      getBusinessManageRequestApiMethod() async {
    final url = Uri.parse("$baseUrl/$businessManageRequestAdminEP");
    final headers = {"Content-Type": "application/json"};
    try {
      final response = await http.get(url, headers: headers);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");
      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return getBusinessManageRequestModelFromJson(response.body);
      } else {
        log('Error fetching businesses: ${response.body}');
        log('1234');
        return null;
      }
    } catch (e) {log('haseeb4');
      log('UnExpected Error fetching businesses: ${e.toString()}');
      return null;
    }
  }

  //Get Recent Businesses
  //Get All Business
  Future<List<GetRecentBusinessModel>?> getRecentBusiness({
    required BuildContext context,
  }) async {
    final url = Uri.parse("$baseUrl/$getRecentBusinessEp");
    log("url :$url");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");

      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return getRecentBusinessModelFromJson(jsonDecode(response.body));
      } else {
        log('Error fetching businesses: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching businesses: ${e.toString()}');
      return null;
    }
  }

  //Change Business Status
  Future<void> changeBusinessStatusApi({
    required String token,
    required String businessId,
    required String status,
    required String rejectionReason,
  }) async {
    final url = Uri.parse("$baseUrl/$changeBusinessStatusEp");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final body = jsonEncode({
      "businessId": businessId,
      "status": status,
      "rejectionReason": rejectionReason
    });
    final response = await http.patch(headers: headers, url, body: body);
    if (response.statusCode == 200) {
      Map<String,dynamic>responseBody=jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(responseBody["message"])));
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

  Future<void> businessManageRequest({
    required String token,
    required String businessId,
  }) async {
    final url = Uri.parse("$baseUrl/$businessManageRequestEP");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    final body = jsonEncode({
      "businessId": businessId,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody["message"] ?? "Success")),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody["message"] ?? "Error")),
          );
        }
      }
    } catch (e) {
      log("Exception: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occurred")),
        );
      }
    }
  }
}
