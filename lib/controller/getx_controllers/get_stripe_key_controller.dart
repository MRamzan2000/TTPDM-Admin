import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/stripe_apis.dart';
import 'package:ttpdm_admin/models/get_stripe_key_model.dart';

class GetStripeKeyController extends GetxController{
  final BuildContext context ;
  GetStripeKeyController({required this.context});
  //getStripe Key
Rxn<GetStripeKeyModel?>stripeKey=Rxn<GetStripeKeyModel?>();
RxBool keyLoading=true.obs;
Future<void>fetchStripeKey({
    required bool loading
})async{
  try{
    keyLoading.value=loading;
    GetStripeKeyModel? data=await StripeApis(context: context).getStripeKeyMethod().then((value) {
      keyLoading.value=false;
    },);
    if(data !=null){
      stripeKey.value=data;
    }else{
      stripeKey.value=null;
    }

  }catch(e){
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unexpected error occurred ${e.toString()}")));
    }
  }
}
}