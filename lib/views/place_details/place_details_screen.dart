import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/place_details/place_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatelessWidget {
  // controller
  PlaceDetailsController controller = Get.put(PlaceDetailsController());

  PlaceDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Obx(() => Text(controller.name.value)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
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
                              colors: [appTheme.blueGray900, appTheme.cyan900],
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
                    Text(
                      controller.description.value,
                      style: CustomTextStyles.bodyMediumGray50,
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
                                              title:
                                                  const Text('KPK Smart Guide'),
                                              content: const Text(
                                                  'The address provided is not valid. Could not open the map.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
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
                        primary: theme.colorScheme.primary,
                        onPrimary: theme.colorScheme.onPrimary,
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
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
