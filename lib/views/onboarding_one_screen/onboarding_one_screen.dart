import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/theme/custom_button_style.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/image_constant.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/widgets/custom_elevated_button.dart';
import 'package:kpksmartguide/views/widgets/custom_image_widget.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [appTheme.blueGray900, appTheme.cyan900])),
                  child: Column(children: [
                    CustomImageView(
                        imagePath: ImageConstant.onBoarding1,
                        height: 420.v,
                        width: 428.h),
                    SizedBox(height: 37.v),
                    _buildInfoSection(),
                    SizedBox(height: 98.v),
                    SizedBox(
                        height: 8.v,
                        child: AnimatedSmoothIndicator(
                            activeIndex: 0,
                            count: 3,
                            effect: ScrollingDotsEffect(
                                spacing: 6,
                                activeDotColor: theme.colorScheme.primary,
                                dotColor: appTheme.blueGray900,
                                dotHeight: 8.v,
                                dotWidth: 8.h))),
                    SizedBox(height: 32.v),
                    _buildSkipSection(),
                    SizedBox(height: 5.v)
                  ]),
                ))));
  }

  /// Section Widget
  Widget _buildInfoSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 43.h),
        child: Column(children: [
          Container(
              width: 307.h,
              margin: EdgeInsets.only(left: 16.h, right: 17.h),
              child: Text("Travel Safely Comfortably",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.headlineLarge!.copyWith(height: 1.50))),
          SizedBox(height: 6.v),
          SizedBox(
              width: 341.h,
              child: Text("Travel safely and comfortably with KPK Smart Guide",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLarge18.copyWith(height: 1.50)))
        ]));
  }

  /// Section Widget
  Widget _buildSkipSection() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomElevatedButton(
              width: 180.h,
              text: "Skip",
              buttonStyle: CustomButtonStyles.fillBlueGray,
              onPressed: () {
                onTapSkip();
              }),
          CustomElevatedButton(
              width: 180.h,
              text: "Next",
              margin: EdgeInsets.only(left: 20.h),
              buttonStyle: CustomButtonStyles.fillBlueGray,
              onPressed: () {
                onTapNext();
              })
        ]));
  }

  /// Navigates to the letSYouInScreen when the action is triggered.
  onTapSkip() {
    // Get.toNamed(
    //   AppRoutes.letSYouInScreen,
    // );
  }

  /// Navigates to the onboardingTwoScreen when the action is triggered.
  onTapNext() {
    Get.toNamed(
      RoutesNames.onBoarding2,
    );
  }
}
