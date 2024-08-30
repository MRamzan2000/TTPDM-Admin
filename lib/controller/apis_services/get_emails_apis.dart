import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_users_emails_model.dart';
import 'package:http/http.dart' as http;

class UsersApis {
  final BuildContext context;
  UsersApis({required this.context});
  //Get Users Email
  Future<List<GetUsersModel>?> userEmail() async {
    final url = Uri.parse("$baseUrl/$getUsersEmailEp");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(headers: headers, url);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");
      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return getUsersModelFromJson(response.body);
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
    }
    return null;
  }
}
