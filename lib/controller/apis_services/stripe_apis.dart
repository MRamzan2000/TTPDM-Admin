import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_stripe_key_model.dart';
import 'package:http/http.dart'as http;

import '../../views/screens/super_admin/bottom_bar.dart';
class StripeApis{
  final BuildContext context;
  StripeApis({required this.context});

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
      log("data :${getStripeKeyModelFromJson(response.body)}");
      return getStripeKeyModelFromJson(response.body);
    }
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }
//edit StripeKey
Future<void>editStripeKeyMethod(
  {
   required String secretKey
}
    ) async{
    final url=Uri.parse("$baseUrl/$editStripeKeyEp");
    final headers={
      "Content-Type":"application/json",
    };
    final body=jsonEncode({
      "secretKey":secretKey
    });
    http.Response response =await http.put(url,headers:headers,body: body);
    if(response.statusCode==200){
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Stripe key Updated Successfully")));
      }
      Get.to(()=>const BottomNavigationBarAdmin());
    }else{
      Map<String , dynamic>responseBody= json.decode(response.body);
      {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(responseBody["message"])));
        }
      }
    }
}
}