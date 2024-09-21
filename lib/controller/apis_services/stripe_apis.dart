import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_stripe_key_model.dart';
import 'package:http/http.dart'as http;
class StripeApis{
  final BuildContext context;
  StripeApis({required this.context});
  //get Stripe Key Api Method

  //get New Admin Code
  Future<GetStripeKeyModel?> getStripeKeyMethod(
     ) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl/$getStripeKeyEp");
    final response = await http.get(url, headers: headers);
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    if (response.statusCode == 200) {
      return getStripeKeyModelFromJson(response.body);
    }
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }
//edit StripeKey
Future<void>editStripeKeyMethod() async{
    final url=Uri.parse("$baseUrl/$editStripeKeyEp");
    final headers={
      "Content-Type":"application/json",
    };
    http.Response response =await http.put(url,headers:headers);
    if(res)
}
}