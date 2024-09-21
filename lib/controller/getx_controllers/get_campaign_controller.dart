import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ttpdm_admin/controller/apis_services/add_campaign_apis.dart';
import 'package:ttpdm_admin/models/get_canpaign_by_status_model.dart';

class AddCampaignController extends GetxController {
  final BuildContext context;
  AddCampaignController({required this.context});
  //getCampaignByStatus
  Rxn<GetCampaignsByStatusModel?> postedCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  Rxn<GetCampaignsByStatusModel?> pendingCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  Rxn<GetCampaignsByStatusModel?> rejectedCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  RxBool isLoading = true.obs;
  Future<void> fetchCampaignByStatus(
      {required BuildContext context,
      required bool isLoad,
      required String status}) async {
    isLoading.value = isLoad;
    final data = await AddCampaignApis(context: context)
        .getCampaignByStatus(status: status);
    if (data != null) {
      status == "pending"
          ? pendingCampaigns.value = data
          : status == "approved"
              ? postedCampaigns.value = data
              : rejectedCampaigns.value = data;
      isLoading.value = false;
    }
  }

  // change Campaign Status
  RxBool rejectLoader = false.obs;
  RxBool approvedLoader = false.obs;
  Future<void> changeCampaignStatus({
    required String token,
    required String campaignId,
    required String status,
    required String rejectionReason,
  }) async {
    try {
      if (status == "rejected") {
        rejectLoader.value = true;
      } else {
        approvedLoader.value = true;
      }
      await AddCampaignApis(context: context)
          .changeCampaignStatusApi(
        token: token,
        campaignId: campaignId,
        status: status,
        rejectionReason: rejectionReason,
      )
          .then(
        (value) {
          rejectLoader.value = false;
          approvedLoader.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        rejectLoader.value = false;
        approvedLoader.value = false;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred :${e.toString()}")));
      }
    }
  }

  //Add Analysis
  RxBool analysisLoader = false.obs;
  Future<void> addAnalysis({
    required String campaignId,
    required String date,
    required String impressions,
    required String clicks,
  }) async {
    try {
      analysisLoader.value = true;
      await AddCampaignApis(context: context)
          .addAnalysisApi(
              campaignId: campaignId,
              date: date,
              impressions: impressions,
              clicks: clicks)
          .then(
        (value) {
          analysisLoader.value = false;
        },
      );
    } catch (e) {
      log("unexpected error occurred :${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred :${e.toString()}")));
        analysisLoader.value=false;
      }
    }
  }
  //Date Picker
  var selectedDate = DateTime.now().obs;

  // Format the date as yyyy-MM-dd
  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate.value);

  // Method to pick a date
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }
}
