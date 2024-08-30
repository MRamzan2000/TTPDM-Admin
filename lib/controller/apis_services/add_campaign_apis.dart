import 'dart:developer';

import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_canpaign_by_status_model.dart';
import 'package:http/http.dart' as http;

class AddCampaignApis {
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
        return getCampaignByStatusModelFromJson(response.body);
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }
}
