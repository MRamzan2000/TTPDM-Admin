import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/getdesigns_model.dart';

class PosterApis {
  final BuildContext context;
  PosterApis({required this.context});
  //Get All design
  Future<GetAllDesignsModel?> getAllDesigns() async {
    final url = Uri.parse("$baseUrl/$getAllDesignsEP");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);

      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return GetAllDesignsModel.fromJson(jsonDecode(response.body));
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
