import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/get_coins_apis.dart';
import 'package:ttpdm_admin/models/get_allcoinsplan_model.dart';

class CoinsController extends GetxController {
  final BuildContext context;
  CoinsController({required this.context});
  // Observables for holding the data and loading state
  RxList<GetAllCoinsPlan?> getAllCoinsPlane = <GetAllCoinsPlan>[].obs;
  RxBool isLoading = true.obs;

  // Method to fetch coin plans
  Future<void> fetchCoinsPlan({
    required String token,
    required bool loading,
    required BuildContext context,
  }) async {
    isLoading.value = loading; // Start loading

    try {
      final data = await GetCoinsApis()
          .getAllCoinsMethod(context: context, token: token);

      if (data != null) {
        getAllCoinsPlane.value = data;
      } else {
        getAllCoinsPlane.clear();
      }
    } catch (e) {
      getAllCoinsPlane.clear();
    } finally {
      isLoading.value = false; // Stop loading regardless of success or failure
    }
  }
}
