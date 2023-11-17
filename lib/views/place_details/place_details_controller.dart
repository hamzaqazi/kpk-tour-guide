import 'dart:developer';

import 'package:get/get.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';

class PlaceDetailsController extends GetxController {
  // variables
  RxString name = ''.obs;
  RxString description = ''.obs;
  RxList images = [].obs;
  RxString address = ''.obs;
  Rx<List<Hotel>> filteredHotels = Rx<List<Hotel>>([]);
  Rx<List<Hotel>> hotels = Rx<List<Hotel>>([]);

  @override
  void onInit() async {
    super.onInit();
    // Get the arguments
    name.value = Get.arguments['name'];
    description.value = Get.arguments['description'];
    images.value = Get.arguments['images'];
    address.value = Get.arguments['address'];

    HotelsService hotelsService = HotelsService();
    hotels.value = await hotelsService.getHotels();
    if (name.value.isNotEmpty) {
      filteredHotels.value = hotels.value
          .where((element) => element.placeID == name.value)
          .toList();
    }

    log(filteredHotels.toString());
  }
}
