import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/business_apis.dart';
import 'package:ttpdm_admin/models/get_all_businesses_model.dart';
import 'package:ttpdm_admin/models/get_business_by_status_model.dart';
import 'package:ttpdm_admin/models/get_business_manage_request_model.dart';

class GetBusinessController extends GetxController {
  final BuildContext context;
  GetBusinessController({required this.context});
  //fetch Business by Status
  Rxn<GetBusinessByStatusModel?> pendingBusiness =
      Rxn<GetBusinessByStatusModel>();
  Rxn<GetBusinessByStatusModel?> approvedBusiness =
      Rxn<GetBusinessByStatusModel>();
  Rxn<GetBusinessByStatusModel?> rejectedBusinesses =
      Rxn<GetBusinessByStatusModel>();
  final RxBool isLoading = true.obs;
  Future<void> fetchBusinessByStatus(
      {required BuildContext context,
      required bool isLoad,
      required String status}) async {
    isLoading.value = isLoad;
    final data = await BusinessApis()
        .getBusinessByStatus(status: status, context: context);
    if (data != null) {
      status == "pending"
          ? pendingBusiness.value = data
          : status == "approved"
              ? approvedBusiness.value = data
              : rejectedBusinesses.value = data;
      isLoading.value = false;
    }
  }

  //get All Business
  final Rxn<GetAllBusinessModel?> allBusinesses = Rxn<GetAllBusinessModel>();
  Future<void> fetchAllBusiness({required bool loading}) async {
    try {
      isLoading.value = loading;
      final data = await BusinessApis().getAllBusiness(context: Get.context!);

      if (data != null) {
        allBusinesses.value = data;
      } else {
        allBusinesses.value = null; // Handle case when data is null
      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      allBusinesses.value = null; // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }

  //fetch business Request Method
  final Rxn<GetBusinessManageRequestModel?> businessRequest =
      Rxn<GetBusinessManageRequestModel>();
  Future<void> fetchAllBusinessManageRequests({required bool loading}) async {
    try {
      isLoading.value = loading;
      final data = await BusinessApis().getBusinessManageRequestApiMethod();

      if (data != null) {
        businessRequest.value = data;
      } else {
        businessRequest.value = null; // Handle case when data is null
      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      businessRequest.value = null; // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }
}
