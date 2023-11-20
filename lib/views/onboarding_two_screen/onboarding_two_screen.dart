import 'package:get/get.dart';
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

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({Key? key}) : super(key: key);

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
            child: Column(
              children: [
                CustomImageView(
                    imagePath: ImageConstant.onBoarding2,
                    height: 420.v,
                    width: 428.h),
                SizedBox(height: 37.v),
                _buildInfoSection(),
                SizedBox(height: 99.v),
                SizedBox(
                    height: 8.v,
                    child: AnimatedSmoothIndicator(
                        activeIndex: 1,
                        count: 3,
                        effect: ScrollingDotsEffect(
                            spacing: 6,
                            activeDotColor: theme.colorScheme.primary,
                            dotColor: appTheme.gray700,
                            dotHeight: 8.v,
                            dotWidth: 8.h))),
                SizedBox(height: 30.v),
                _buildSkipSection(),
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildInfoSection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 43.h),
        child: Column(children: [
          Container(
              width: 327.h,
              margin: EdgeInsets.only(left: 7.h, right: 5.h),
              child: Text("Find the best hotels",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.headlineLarge!.copyWith(height: 1.50))),
          SizedBox(height: 18.v),
          SizedBox(
              width: 488,
              child: Text(
                  "Discover Khyber Pakhtunkhwa with ease! Find the best hotels that match your style and budget, ensuring a comfortable stay throughout your journey. From luxurious retreats to cozy accommodations, our app makes hotel hunting a breeze.",
                  maxLines: 6,
                  overflow: TextOverflow.clip,
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
    Get.offAllNamed(
      RoutesNames.home,
    );
  }

  /// Navigates to the onboardingThreeScreen when the action is triggered.
  onTapNext() {
    Get.toNamed(
      RoutesNames.onBoarding3,
    );
  }
}
