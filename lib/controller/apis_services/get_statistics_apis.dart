import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_statistics_model.dart';
import 'package:http/http.dart' as http;

class StatisticsApi {
  final BuildContext context;
  StatisticsApi({required this.context});
  //get Subscription Count Api Method
  Future<List<GetStatisticsModel>?> getStatisticsApiMethod() async {
    final url = Uri.parse("$baseUrl/$getStatisticsEp");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(headers: headers, url);
      if (response.statusCode == 200) {
        log("response :${response.body}");
        return getStatisticsModelFromJson(response.body);
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
}
