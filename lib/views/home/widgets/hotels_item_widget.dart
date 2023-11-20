import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/theme/app_decoration.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/image_constant.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/widgets/custom_image_widget.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HotelsItemWidget extends StatelessWidget {
  final String? name;
  final String? description;
  final String? address;
  final List<dynamic>? images;
  final String? speciality;

  const HotelsItemWidget({
    Key? key,
    this.name,
    this.description,
    this.address,
    this.images,
    this.speciality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.v,
      width: 300.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: images![0],
            height: 450.v,
            width: 300.h,
            radius: BorderRadius.circular(
              36.h,
            ),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.placeDetails, arguments: {
                      'name': name,
                      'description': description,
                      'address': address,
                      'images': images,
                      'speciality': speciality,
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 17.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 8.v,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.h),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          appTheme.blueGray900,
                          appTheme.cyan900,
                        ],
                      ),
                    ),
                    child: Text(
                      'See Details',
                      style: CustomTextStyles.titleSmallWhiteA700,
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(right: 17.h),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8.h,
                //     vertical: 4.v,
                //   ),
                //   decoration: BoxDecoration(
                //     color: theme.colorScheme.primary,
                //     borderRadius: BorderRadius.circular(16.h),
                //   ),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       CustomImageView(
                //         imagePath: ImageConstant.starIcon,
                //         height: 18.adaptSize,
                //         width: 18.adaptSize,
                //       ),
                //       SizedBox(width: 4.h),
                //       Text(
                //         '4.8',
                //         style: CustomTextStyles.titleSmallWhiteA700,
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 290.v),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.h,
                    vertical: 8.v,
                  ),
                  decoration: AppDecoration.gradient.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderBL36,
                    color: Colors.black,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(height: 8.v),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          name.toString(),
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                      // SizedBox(height: 8.v),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // place icon small
                            Icon(
                              CupertinoIcons.map_pin_ellipse,
                              color: theme.colorScheme.primary,
                              // size: 18.adaptSize,
                            ),

                            Text(
                              address.toString(),
                              style: theme.textTheme.bodyLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10.v),
                      GestureDetector(
                        onTap: () {
                          // show dailog with confirmation to open address in a google map
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
                                      if (address.toString().trim().isEmpty ||
                                          address == null) {
                                        return;
                                      }
                                      // Navigator.of(context).pop();
                                      Navigator.pop(Get.context!);
                                      String query = Uri.encodeComponent(
                                          address.toString());
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.v),
                              // navigate icon
                              child: Icon(
                                CupertinoIcons.map_fill,
                                color: theme.colorScheme.primary,
                                // size: 18.adaptSize,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 4.h,
                                top: 9.v,
                                bottom: 5.v,
                              ),
                              child: Text(
                                'Open Map',
                                style: CustomTextStyles.bodyMediumWhiteA700,
                              ),
                            ),
                            const Spacer(),
                            // container and inside a ticket icon
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: 16.h,
                            //     vertical: 8.v,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(16.h),
                            //     gradient: LinearGradient(
                            //       begin: Alignment.topCenter,
                            //       end: Alignment.bottomCenter,
                            //       colors: [
                            //         appTheme.blueGray900,
                            //         appTheme.cyan900,
                            //       ],
                            //     ),
                            //   ),
                            //   child: Text(
                            //     'Details',
                            //     style: CustomTextStyles.titleSmallWhiteA700,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
