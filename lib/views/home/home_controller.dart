import 'dart:developer';

import 'package:get/get.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';

class HomeController extends GetxController {
  HotelsService hotelsService = HotelsService();
  Rx<List<Hotel>> hotels = Rx<List<Hotel>>([]);
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
