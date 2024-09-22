import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/stripe_apis.dart';
import 'package:ttpdm_admin/models/get_stripe_key_model.dart';

class GetStripeKeyController extends GetxController {
  final BuildContext context;
  GetStripeKeyController({required this.context});
  //getStripe Key
  Rxn<GetStripeKeyModel?> stripeKey = Rxn<GetStripeKeyModel?>();
  RxBool keyLoading = true.obs;
  Future<void> fetchStripeKey({required bool loading}) async {
    try {
      keyLoading.value = loading;
      final data = await StripeApis(context: context).getStripeKeyMethod();
      keyLoading.value = false;

      if (data != null) {
        log("data is not null");
        stripeKey.value = data;
        log("Fetched secret key: ${stripeKey.value?.secretKey}");
      } else {
        log("data is null");
        stripeKey.value = null;
      }
    } catch (e) {
      keyLoading.value = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unexpected error occurred ${e.toString()}"),
        ));
      }
    }
  }
  //Edit Stripe key
  RxBool editLoading=false.obs;
Future<void>updateStripeKey(
  {
    required String secretKey
}
    )async{
    try{
      editLoading.value=true;
      await StripeApis(context: context).editStripeKeyMethod(secretKey: secretKey).then((value) {
        editLoading.value=false;
      },);
    }catch(e){
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred ${e.toString()}")));
      }
    }
}
}
