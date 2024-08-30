import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/add_campaign_apis.dart';
import 'package:ttpdm_admin/models/get_canpaign_by_status_model.dart';

class AddCampaignController extends GetxController {
  //getCampaignByStatus
  Rxn<GetCampaignsByStatusModel?> previousCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  Rxn<GetCampaignsByStatusModel?> pendingCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  Rxn<GetCampaignsByStatusModel?> upcomingCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  RxBool isLoading = false.obs;
  Future<void> fetchCampaignByStatus(
      {required BuildContext context,
      required bool isLoad,
      required String status}) async {
    isLoading.value = isLoad;
    final data = await AddCampaignApis().getCampaignByStatus(status: status);
    if (data != null) {
      status == "previous"
          ? previousCampaigns.value = data
          : status == "pending"
              ? pendingCampaigns.value = data
              : upcomingCampaigns.value = data;
      isLoading.value = false;
    }
  }
}
