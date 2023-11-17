import 'package:get/get.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';

class PlaceDetailsController extends GetxController {
  // variables
  RxString name = ''.obs;
  RxString description = ''.obs;
  RxList images = [].obs;
  RxString address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the arguments
    name.value = Get.arguments['name'];
    description.value = Get.arguments['description'];
    images.value = Get.arguments['images'];
    address.value = Get.arguments['address'];

    HotelsService hotelsService = HotelsService();
    hotelsService.getHotels().then((value) {
      // make a lits of hotels.placeID match with name.value
    });
  }
}
