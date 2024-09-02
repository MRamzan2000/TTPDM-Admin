import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/get_statistics_apis.dart';
import 'package:ttpdm_admin/models/get_statistics_model.dart';

class GetStatisticsController extends GetxController {
  final BuildContext context;
  GetStatisticsController({required this.context});
  //get Statistics Method
  final RxBool isLoading = true.obs;
  RxList<GetStatisticsModel?> statics = <GetStatisticsModel>[].obs;
  Future<void> fetchStatistics({required bool loading}) async {
    try {
      isLoading.value = loading;
      final data =
          await StatisticsApi(context: context).getStatisticsApiMethod();

      if (data != null) {
        statics.value = data;
      } else {
        statics.value = []; // Handle case when data is null
      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      statics.value = []; // Handle exceptions
    } finally {
      isLoading.value = false;
      statics.value = [];
    }
  }
}
