import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_all_design_request_model.dart';
import 'package:http/http.dart'as http;
class GetAllDesignApi{
  final BuildContext context;
  GetAllDesignApi({required this.context});
  //GetBusiness Profile
  Future<List<GetAllDesignRequestModel>?> getAllDesignRequest(
      {required BuildContext context, }) async {
    final url = Uri.parse("$baseUrl/$getDesignRequestEP");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");

      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return getAllDesignRequestModelFromJson(response.body);
      } else {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }
}