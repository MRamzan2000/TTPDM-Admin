import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_allcoinsplan_model.dart';

class GetCoinsApis {
  final BuildContext context;
  GetCoinsApis({required  this.context});
  // Get coin plans
  Future<List<GetAllCoinsPlan>?> getAllCoinsMethod({
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
  //Create New Plane
  Future<void> createNewCoinsPlan({
    required numberOfCoins,
    required coinsPrice,
    required token,
  }) async {
    final url = Uri.parse("$baseUrl/$addNewCoinsPlanEP");
    final headers = {
      "Content-Type": 'application/json',
      "Authorization": 'Bearer $token',
    };
    final body =
    jsonEncode({"amount": numberOfCoins, "priceInCents": coinsPrice});
    final response = await http.post(headers: headers, url, body: body);
    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add New CoinsPlan Successfully")));
      }
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${responseBody["message"]}")));
      }
    }
  }
  //update coins plan
  Future<void>updateCoinsPlanApiMethod(
      {
        required numberOfCoins,
        required coinsPrice,
        required coinsPlanId,
        required token,
      })async{
    final url = Uri.parse("$baseUrl/$updateCoinsPlanEP/$coinsPlanId");
    final headers = {
      "Content-Type": 'application/json',
      "Authorization": 'Bearer $token',
    };
    final body =
    jsonEncode(
        {"amount": numberOfCoins, "priceInCents": coinsPrice});
    final response = await http.put(headers: headers, url, body: body);
    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Update CoinsPlan Successfully")));
      }
      Get.back();
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${responseBody["message"]}")));
      }
    }
  }
//Delete Coins Plan
  Future<void>deleteCoinsPlanApiMethod(
      {
        required coinsPlanId,
        required token,
      })async{
    final url = Uri.parse("$baseUrl/$deleteCoinsPlanEP/$coinsPlanId");
    final headers = {
      "Content-Type": 'application/json',
      "Authorization":"Bearer $token"
    };
    final response = await http.delete(headers: headers, url, );
    log("statusCode ${response.statusCode}");
    log("body ${response.body}");
    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Coin deleted successfully")));
      }
    }else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${responseBody["message"]}")));
      }
    }
  }
}
