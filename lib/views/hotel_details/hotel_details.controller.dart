import 'package:get/get.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';

class HotelDetailsController extends GetxController {
  RxString name = ''.obs;
  RxList images = [].obs;
  RxString address = ''.obs;
  RxDouble rating = 0.0.obs;
  RxDouble price = 0.0.obs;
  RxString placeID = ''.obs;

  HotelsService hotelsService = HotelsService();
  Rx<List<Hotel>> otherHotels = Rx<List<Hotel>>([]);
  Rx<List<Hotel>> hotels = Rx<List<Hotel>>([]);
  @override
  void onInit() async {
    super.onInit();
    // Get the arguments
    name.value = Get.arguments['name'];
    images.value = Get.arguments['images'];
    address.value = Get.arguments['address'];
    price.value = Get.arguments['price'];
    rating.value = Get.arguments['rating'];
    placeID.value = Get.arguments['placeID'];

    // get the hotels from the placeID
    hotels.value = await hotelsService.getHotels();
    if (placeID.value.isNotEmpty) {
      otherHotels.value = hotels.value
          .where((element) =>
              element.placeID == placeID.value && element.name != name.value)
          .toList();
    }
  }
}
