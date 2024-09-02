import 'dart:developer';

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
      final data = await GetCoinsApis(context: context)
          .getAllCoinsMethod( token: token);

      if (data != null) {
        getAllCoinsPlane.value = data;
        log("when data is not null :$getAllCoinsPlane");
        isLoading.value = false;
      } else {
        getAllCoinsPlane.clear();
        log("when data clear :$getAllCoinsPlane");
        isLoading.value = false;
      }
    } catch (e) {
      log("Unexpected error occurred :${e.toString()}");
      isLoading.value = false;
      log("when data clear :$getAllCoinsPlane");

      getAllCoinsPlane.clear();
    }
  }

  //Create New Coins Plan of Coins
  final RxBool coinsLoading = false.obs;
  Future<void> createNewCoinsPlan({
    required numberOfCoins,
    required coinsPrice,
    required token,
  }) async {
    try {
      coinsLoading.value = true;
      GetCoinsApis(context: context)
          .createNewCoinsPlan(numberOfCoins: numberOfCoins, coinsPrice: coinsPrice, token: token)
          .then(
            (value) {
          coinsLoading.value = false;
        },
      );
    } catch (e) {
      log("unexpected error occurred ${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred ${e.toString()}")));
      }
    }
  }

  //update coins Plan
  Future<void> updateCoinsPlan({
    required numberOfCoins,
    required coinsPrice,
    required coinsPlanId,
    required token,
  }) async {
    try {
      coinsLoading.value = true;
      GetCoinsApis(context: context)
          .updateCoinsPlanApiMethod(
          numberOfCoins: numberOfCoins,
          coinsPrice: coinsPrice,
          coinsPlanId: coinsPlanId, token: token)
          .then(
            (value) {
          coinsLoading.value = false;
        },
      );
    } catch (e) {
      log("unexpected error occurred ${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred ${e.toString()}")));
      }
    }
  }

  //Delete Coins Plan
  Future<void> deleteCoinsPlan({
    required coinsPlanId,
    required token,
  }) async {
    try {
      coinsLoading.value = true;
      GetCoinsApis(context: context)
          .deleteCoinsPlanApiMethod(coinsPlanId: coinsPlanId, token: token)
          .then(
            (value) {
          coinsLoading.value = false;
        },
      );
    } catch (e) {
      log("unexpected error occurred ${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred ${e.toString()}")));
      }
    }
  }
}
