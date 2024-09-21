import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/get_statistics_apis.dart';
import 'package:ttpdm_admin/models/get_monthly_states_model.dart';
import 'package:ttpdm_admin/models/get_statistics_model.dart';

class GetStatisticsController extends GetxController {
  final BuildContext context;
  GetStatisticsController({required this.context});
  //get Statistics Method
  final RxBool statsLoading=true.obs;
  final RxBool statisticsLoading=true.obs;
  //percentage = currentMonth / lastMonth * 100
  final RxDouble totalUserPercentage=0.0.obs;
  final RxDouble campaignPercentage=0.0.obs;
  final RxDouble cancellationPercentage=0.0.obs;
  final RxDouble returnRatePercentage=0.0.obs;
  final RxBool totalUser = false.obs;
  final RxBool campaign = false.obs;
  final RxBool cancellation = false.obs;
  final RxBool returnRate = false.obs;

  RxList<GetStatisticsModel?> statics = <GetStatisticsModel>[].obs;
  Future<void> fetchStatistics({required bool loading}) async {
    try {
      statisticsLoading.value = loading;
      final data =
          await StatisticsApi(context: context).getStatisticsApiMethod();

      if (data != null) {
        statics.value = data;
      } else {
        statics.value = []; // Handle case when data is null
      }
      statisticsLoading.value = false;
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      statics.value = []; // Handle exceptions
    } finally {
      statisticsLoading.value = false;
    }
  }

  Rxn<GetAllStatesModel?> monthlyStatics = Rxn<GetAllStatesModel>();
  Future<void> fetchMonthlyStates({required bool loading}) async {
    try {
      statsLoading.value = loading;
      GetAllStatesModel? data =
      await StatisticsApi(context: context).getMonthlyStates();

      if (data != null) {
        monthlyStatics.value = data;
        totalUserPercentage.value=calculatePercentage(monthlyStatics.value!.totalUsers.thisMonth, monthlyStatics.value!.totalUsers.lastMonth);
        campaignPercentage.value=calculatePercentage(monthlyStatics.value!.campaigns.created.thisMonth, monthlyStatics.value!.campaigns.created.lastMonth);
        cancellationPercentage.value=calculatePercentage(monthlyStatics.value!.cancellations.thisMonth, monthlyStatics.value!.cancellations.lastMonth);
        returnRatePercentage.value=calculatePercentage(monthlyStatics.value!.returnRate.thisMonth, monthlyStatics.value!.returnRate.lastMonth );
        totalUser.value = totalUserPercentage.value >= 0;
        campaign.value = campaignPercentage.value >= 0;
        cancellation.value = cancellationPercentage.value >= 0;
        returnRate.value = returnRatePercentage.value >= 0;
      } else {
        monthlyStatics.value = null; // Handle case when data is null
        log("data is null");
      }
      statsLoading.value=false;
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      log("data is null");
      monthlyStatics.value = null; // Handle exceptions
    } finally {
      statsLoading.value = false;
    }
  }
}

double calculatePercentage(double thisMonth, double lastMonth) {
  thisMonth = thisMonth == 0 ? 0.0 : thisMonth;
  lastMonth = lastMonth == 0 ? 0.0 : lastMonth;
  double percentage = lastMonth != 0 ? (thisMonth / lastMonth * 100) : 0.0;
  return double.parse(percentage.toStringAsFixed(2));
}