import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_allcoinsplan_model.dart';



class GetCoinsApis {
  // Get coin plans
  Future<List<GetAllCoinsPlan>?> getAllCoinsMethod({
    required BuildContext context,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/$getAllCoinsPlanEP");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        log('Response: ${response.body}');
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => GetAllCoinsPlan.fromJson(data))
            .toList();
      } else {
        log('Error fetching coin plans: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Unexpected error fetching coin plans: ${e.toString()}');
      return null;
    }
  }

}