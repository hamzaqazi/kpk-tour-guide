import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/hotel_details/hotel_details.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/widgets/martinezcannes_item_widget.dart';

class HotelDetailsScreen extends StatelessWidget {
  // controller
  HotelDetailsController controller = Get.put(HotelDetailsController());

  HotelDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.toNamed(RoutesNames.home),
        ),
        title: Obx(() => Text(controller.name.value)),
      ),

      body: WillPopScope(
        onWillPop: () async {
          Get.toNamed(RoutesNames.home);
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            // screen height
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [appTheme.blueGray900, appTheme.cyan900],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Images in a grid view builder

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CarouselSlider(
                    items: controller.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: Get.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  appTheme.blueGray900,
                                  appTheme.cyan900
                                ],
                              ),
                              // rounded corners
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(i),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 400.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(controller.name.value,
                          style: CustomTextStyles.bodyLarge30),
                      SizedBox(height: 8),
                      // description section
                      Text(controller.description.value,
                          style: CustomTextStyles.bodyMediumGray50),
                      // rating section
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: theme.colorScheme.primary,
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                            child: Text(
                              "${controller.rating.value.toString()} Rating",
                              style: CustomTextStyles.bodyLarge18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // price section
                      Row(
                        children: [
                          Icon(
                            Icons.money,
                            color: theme.colorScheme.primary,
                            size: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'Rs. ${controller.price.value.toString()}',
                                style: CustomTextStyles.bodyLarge30,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '/night',
                                    style: CustomTextStyles.bodyLarge18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // address section

                      SizedBox(height: 16),
                      Text('Address', style: CustomTextStyles.bodyLarge30),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: theme.colorScheme.primary,
                            size: 30,
                          ),
                          Expanded(
                            child: Text(
                              controller.address.value,
                              style: CustomTextStyles.bodyMediumGray50,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // open google map button
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('KPK Smart Guide'),
                                content: const Text(
                                    'Do you want to open this address in Google Maps?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () async {
                                      if (controller.address
                                              .toString()
                                              .trim()
                                              .isEmpty ||
                                          controller.address == null) {
                                        return;
                                      }
                                      // Navigator.of(context).pop();
                                      Navigator.pop(Get.context!);
                                      String query = Uri.encodeComponent(
                                          controller.address.toString());
                                      String googleUrl =
                                          "https://www.google.com/maps/search/?api=1&query=$query";
                                      // googleUrl to uri object
                                      Uri googleUri = Uri.parse(googleUrl);
                                      // if (await canLaunchUrl(googleUri)) {
                                      //   await launchUrl(googleUri);
                                      // } else {
                                      //   log('Could not open the map.');
                                      // }
                                      launchUrl(googleUri).onError(
                                        (error, stackTrace) {
                                          // show dailog with error message
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'KPK Smart Guide'),
                                                content: const Text(
                                                    'The address provided is not valid. Could not open the map.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          return false;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: theme.colorScheme.onPrimary,
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Open Google Map',
                          style: CustomTextStyles.bodyMediumWhiteA700,
                        ),
                      ),
                    ],
                  ),
                  // opne google map button
                ),
                SizedBox(height: 16),
                // Hotels to stay section
                Obx(
                  () => _buildHotelsToStay(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hotels to stay section
  Widget _buildHotelsToStay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.h, left: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Other hotels in this area".tr,
                  style: theme.textTheme.titleMedium),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.allHotels,
                        arguments: {"All Hotels": "All Hotels"});
                  },
                  child: Text("See All".tr,
                      style: CustomTextStyles.titleMediumPrimary16))
            ],
          ),
        ),
        SizedBox(height: 16.v),
        controller.otherHotels.value.isEmpty
            ? Container(
                padding: EdgeInsets.only(right: 24.h),
                height: 100,
                child: Center(
                  child: Text('No Other hotels found in this place',
                      style: CustomTextStyles.bodyMediumGray50),
                ),
              )
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.v);
                },
                itemCount: controller.otherHotels.value.length,
                itemBuilder: (context, index) {
                  var hotel = controller.otherHotels.value[index];

                  return MartinezcannesItemWidget(
                    images: hotel.images,
                    name: hotel.name,
                    address: hotel.address,
                    price: hotel.price,
                    rating: hotel.rating,
                    placeID: hotel.placeID,
                    description: hotel.description,
                  );
                },
              ),
      ],
    );
  }
}
