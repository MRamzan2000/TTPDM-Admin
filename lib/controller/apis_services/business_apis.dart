import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_all_businesses_model.dart';
import 'package:ttpdm_admin/models/get_business_by_status_model.dart';
import 'package:http/http.dart' as http;


class BusinessApis {
  //GetBusiness Profile
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
  Future<GetAllBusinessModel?> getAllBusiness(
      {required BuildContext context, }) async {
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
}
