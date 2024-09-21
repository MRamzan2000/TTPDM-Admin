import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/business_apis.dart';
import 'package:ttpdm_admin/models/get_all_businesses_model.dart';
import 'package:ttpdm_admin/models/get_business_by_status_model.dart';
import 'package:ttpdm_admin/models/get_business_manage_request_model.dart';
import 'package:ttpdm_admin/models/get_recent_business_model.dart';

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
    final data = await BusinessApis(context: context)
        .getBusinessByStatus(status: status, context: context);
    if (data != null) {
      status == "pending"
          ? pendingBusiness.value = data
          : status == "accepted"
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
      final data = await BusinessApis(context: context)
          .getAllBusiness(context: Get.context!);

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

  //get Recent Business
  final RxList<GetRecentBusinessModel> recentBusinesses =
      <GetRecentBusinessModel>[].obs;
  Future<void> fetchRecentBusiness({required bool loading}) async {
    try {
      isLoading.value = loading;
      final data = await BusinessApis(context: context)
          .getRecentBusiness(context: Get.context!);

      if (data != null) {
        recentBusinesses.value = data;
      } else {
        recentBusinesses.value = []; // Handle case when data is null
      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      recentBusinesses.value = []; // Handle exceptions
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
      final data = await BusinessApis(context: context)
          .getBusinessManageRequestApiMethod();

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

  //change Business Status
  RxBool rejectLoader = false.obs;
  RxBool approvedLoader = false.obs;
  Future<void> changeBusinessStatus({
    required String token,
    required String businessId,
    required String status,
    required String rejectionReason,
  }) async {
    try {
      if (status == "rejected") {
        rejectLoader.value = true;
      } else {
        approvedLoader.value = true;
      }
      await BusinessApis(context: context)
          .changeBusinessStatusApi(
              token: token,
              businessId: businessId,
              status: status,
              rejectionReason: rejectionReason)
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

  //Business Manage Request
  RxBool businessManageLoader = false.obs;

  Future<void> businessManageRequest({
    required String token,
    required String businessId,
  }) async {
    try {
      businessManageLoader.value = true;
      await BusinessApis(context: Get.context!)
          .businessManageRequest(
        token: token,
        businessId: businessId,
      );
    } catch (e) {
      businessManageLoader.value = false;
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text("Unexpected error occurred: ${e.toString()}")),
        );
      }
    } finally {
      businessManageLoader.value = false;
    }
  }
}
