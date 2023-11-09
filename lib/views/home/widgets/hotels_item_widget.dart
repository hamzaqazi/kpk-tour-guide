import 'package:kpksmartguide/theme/app_decoration.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/image_constant.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/widgets/custom_image_widget.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HotelsItemWidget extends StatelessWidget {
  const HotelsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.v,
      width: 300.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.onBoarding2,
            height: 400.v,
            width: 300.h,
            radius: BorderRadius.circular(
              36.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 23.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 4.v,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.starIcon,
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                      ),
                      SizedBox(width: 4.h),
                      Text(
                        '4.8',
                        style: CustomTextStyles.titleSmallWhiteA700,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 172.v),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.h,
                    vertical: 21.v,
                  ),
                  decoration: AppDecoration.gradient.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderBL36,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 16.v),
                      Text(
                        'Hotel Name',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 15.v),
                      Text(
                        'Address of the hotel',
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10.v),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.v),
                            child: Text(
                              'Rs.2000 ',
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              top: 9.v,
                              bottom: 5.v,
                            ),
                            child: Text(
                              '/night',
                              style: CustomTextStyles.bodyMediumWhiteA700,
                            ),
                          ),
                          Spacer(),
                          // container and inside a ticket icon
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.h,
                              vertical: 4.v,
                            ),
                            // decoration: BoxDecoration(
                            //   color: theme.colorScheme.primary,
                            //   borderRadius: BorderRadius.circular(16.h),
                            // ),
                            child: Icon(
                              Icons.hotel_class_outlined,
                              color: Colors.white,
                              size: 28.adaptSize,
                            ),
                          ),
                        ],
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
