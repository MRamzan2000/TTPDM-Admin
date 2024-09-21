import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/get_design_api.dart';
import 'package:ttpdm_admin/models/get_all_design_request_model.dart';

class DesignRequestController extends GetxController {
  final RxList<GetAllDesignRequestModel?> getDesignRequest = RxList<GetAllDesignRequestModel>();
  final RxBool isLoading = true.obs;

  Future<void> fetchDesignRequest({required bool loading}) async {
    try {
      isLoading.value = loading;
      final api = GetAllDesignApi(context: Get.context!);
      final data = await api.getAllDesignRequest(context: Get.context!);

      if (data != null) {
        getDesignRequest.value = data;
      } else {
        getDesignRequest.value = []; // Handle case when data is null
      }
      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;

      log("Unexpected error occurred: ${e.toString()}");
      getDesignRequest.value = []; // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }
  //Upload Design
//update profile
  RxBool uploading = false.obs;
  Future<void> uploadProfileImage({
    required String token,
    required File designs, // Expecting a File object for image
    required BuildContext context, // Expecting a File object for image
  }) async {
    try {
      uploading.value = true;
      await GetAllDesignApi(context: context)
          .uploadDesign(token: token,  design: designs, context: context)
          .then(
            (value) {
          uploading.value = false;
        },
      );
    } catch (e) {
      log("Unexpected error occurred :${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("unexpected error occurred :${e.toString()}")));
      uploading.value = false;
    }
  }
}

