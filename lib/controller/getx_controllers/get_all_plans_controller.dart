import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/get_all_plans_api.dart';
import 'package:ttpdm_admin/models/get_all_plans_model.dart';

class AllPlansController extends GetxController {
  final BuildContext context;
  AllPlansController({required this.context});
  // Observables for holding the data and loading state
  RxList<GetAllPlansModel?> getAllPlans = <GetAllPlansModel>[].obs;
  RxBool isLoading = true.obs;

  // Method to fetch coin plans
  Future<void> fetchAllPlans({
    required bool loading,
    required BuildContext context,
  }) async {
    isLoading.value = loading; // Start loading

    try {
      final data = await GetAllPlansApi(context: context).getAllPlans();

      if (data != null) {
        getAllPlans.value = data;
        log("when data is not null :$getAllPlans");
        isLoading.value = false;
      } else {
        getAllPlans.clear();
        log("when data clear :$getAllPlans");
        isLoading.value = false;
      }
    } catch (e) {
      log("Unexpected error occurred :${e.toString()}");
      isLoading.value = false;
      log("when data clear :$getAllPlans");

      getAllPlans.clear();
    }
  }

  // //Create New Sub Plan of Coins
  final RxBool subplanLoading = false.obs;
  // Future<void> createNewSubPlan({
  //   required name,
  //   required price,
  //   required businessLimit,
  // }) async {
  //   try {
  //     coinsLoading.value = true;
  //     GetAllPlansApi(context: context)
  //         .createNewSubPlan(
  //             name: name, price: price, businessLimit: businessLimit)
  //         .then(
  //       (value) {
  //         coinsLoading.value = false;
  //       },
  //     );
  //   } catch (e) {
  //     log("unexpected error occurred ${e.toString()}");
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("unexpected error occurred ${e.toString()}")));
  //     }
  //   }
  // }

  //update coins Plan
  Future<void> updateSubPlan({
    required name,
    required token,
    required price,
    required businessLimit,
    required subPlanId,
  }) async {
    try {
      subplanLoading.value = true;
      GetAllPlansApi(context: context)
          .updateSubPlanApiMethod(
              name: name,
              price: price,
              businessLimit: businessLimit,
              subPlanId: subPlanId,
              token: token)
          .then(
        (value) {

          subplanLoading.value = false;
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

  // //Delete Coins Plan
  // Future<void> deleteCoinsPlan({
  //   required subPlanPlanId,
  // }) async {
  //   try {
  //     coinsLoading.value = true;
  //     GetAllPlansApi(context: context)
  //         .deleteCoinsPlanApiMethod(subPlanPlanId: subPlanPlanId)
  //         .then(
  //       (value) {
  //         coinsLoading.value = false;
  //       },
  //     );
  //   } catch (e) {
  //     log("unexpected error occurred ${e.toString()}");
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("unexpected error occurred ${e.toString()}")));
  //     }
  //   }
  // }
}
