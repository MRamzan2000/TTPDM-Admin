import 'dart:developer';

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
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      getDesignRequest.value = []; // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }
}

