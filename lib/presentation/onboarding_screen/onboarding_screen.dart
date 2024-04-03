import 'package:boat_rent/core/app_export.dart';
import 'package:boat_rent/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.h),
            child: CustomImageView(
              fit: BoxFit.fitWidth,
              imagePath: ImageConstant.img273825477327066,
            ),
          ),
          SizedBox(
            height: 70.v,
          ),
          Column(
            children: [
              Text(
                'Manage your rental',
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.v,
              ),
              Text(
                'Keep track of your water\ntransportation rentals',
                style: CustomTextStyles.bodyLargeOnPrimaryContainer,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: CustomElevatedButton(
          text: 'Next',
          onPressed: () {
            NavigatorService.pushNamed(AppRoutes.startInfoScreen);
          },

        ),
      ),
    );
  }
}
