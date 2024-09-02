import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserProfileApi {
  final BuildContext context;
  UserProfileApi({required this.context});
  //get User Profile
  Future<GetUserProfileModel?> getUserProfile(
  {
    required String id
}
      ) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl/$getUserProfileEp/$id");
    final response = await http.get(url, headers: headers);
    log("body try${response.body}");
    log("statusCode try${response.statusCode}");
    if (response.statusCode == 200) {
      log("response body:${response.body}");
      return getUserProfileModelFromJson(response.body);
    }
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }
}
