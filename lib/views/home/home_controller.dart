import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';

class HomeController extends GetxController {
  HotelsService hotelsService = HotelsService();
  Rx<List<Hotel>> hotels = Rx<List<Hotel>>([]);
  TextEditingController passwordController = TextEditingController();
  RxBool isAdmin = false.obs;
  @override
  void onInit() async {
    await hotelsService.getHotels().then((value) {
      hotels.value = value;
      update();
    });
    log(hotels.value.toString());
    super.onInit();
  }
}
