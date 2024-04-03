import 'package:boat_rent/core/app_export.dart';
import 'package:boat_rent/data/data_manager.dart';
import 'package:boat_rent/data/models/boat_model/boat_model.dart';
import 'package:boat_rent/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_elevated_button.dart';

class TransportInfoScreen extends StatelessWidget {
  final BoatModel boatModel;

  const TransportInfoScreen({super.key, required this.boatModel});

  static Widget builder(BuildContext context, BoatModel boatModel) {
    return TransportInfoScreen(
      boatModel: boatModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 52.v,
        leadingWidth: 100.h,
        leading: Container(
          width: 85.h,
          child: TextButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios),
                SizedBox(width: 4.h),
                Text(
                  'Back',
                  style: CustomTextStyles.bodyLargePrimary,
                ),
              ],
            ),
            onPressed: () {
              NavigatorService.goBack();
            },
          ),
        ),
        actions: [
          Container(
            width: 85.h,
            child: TextButton(
              child: Text(
                'Edit',
                style: CustomTextStyles.bodyLargePrimary,
              ),
              onPressed: () {
                NavigatorService.popAndPushNamed(AppRoutes.newTransportScreen);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: CustomElevatedButton(
          text: 'Delete transport',
          onPressed: () async {
            await DataManager.removeBoatFromList(boatModel);
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
          },
          buttonStyle: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                theme.colorScheme.primary.withOpacity(.3), // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Transport info',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 20.v,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
                decoration: AppDecoration.surface2
                    .copyWith(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    _infoText(
                      context,
                      imagePath: ImageConstant.imgMaterialSymbol,
                      name: 'Type',
                      content: Text(
                        boatModel.type,
                        style: CustomTextStyles.bodyLargePrimary,
                      ),
                    ),
                    SizedBox(
                      height: 12.v,
                    ),
                    _infoText(
                      context,
                      imagePath: ImageConstant.imgDollarSign,
                      name: 'Rental cost',
                      content: Text(
                        '${boatModel.rentalCost.toInt()}\$',
                        style: CustomTextStyles.bodyLargePrimary,
                      ),
                    ),
                    SizedBox(
                      height: 12.v,
                    ),
                    _infoText(
                      context,
                      imagePath: ImageConstant.imgCalendar,
                      name: 'Payment type',
                      content: Text(
                        boatModel.paymentType.name.capitalize(),
                        style: CustomTextStyles.bodyLargePrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.v,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
                decoration: AppDecoration.surface2
                    .copyWith(borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    _infoText(
                      context,
                      imagePath: ImageConstant.imgTool,
                      name: 'State',
                      content: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: AppDecoration.surface1,
                        height: 28.v,
                        child: Center(
                            child: _transportStateText(
                                context, boatModel.boatState)),
                      ),
                    ),
                    SizedBox(
                      height: 12.v,
                    ),
                    _infoText(
                      context,
                      imagePath: ImageConstant.imgUser,
                      name: 'Who rent',
                      content: Text(
                        boatModel.whoRents,
                        style: CustomTextStyles.bodyLargePrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.v,
              ),
              Text(
                'Comments',
                style: CustomTextStyles.bodyLargeOnPrimaryContainer,
              ),
              SizedBox(
                height: 12.v,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.v),
                decoration: AppDecoration.surface2
                    .copyWith(borderRadius: BorderRadius.circular(10)),
                child: Text(
                  boatModel.comment,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transportStateText(BuildContext context, BoatState boatState) {
    switch (boatState) {
      case BoatState.perfect:
        return Text(
          'Perfect',
          style: CustomTextStyles.bodyLargeSecondaryContainer,
        );
      case BoatState.average:
        return Text(
          'Average',
          style: CustomTextStyles.bodyLargeDeeporange800,
        );
      case BoatState.bad:
        return Text(
          'Bad',
          style: CustomTextStyles.bodyLargeRed800,
        );
    }
  }

  Widget _infoText(BuildContext context,
      {String imagePath = '', String name = '', required Widget content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              fit: BoxFit.fitWidth,
              imagePath: imagePath,
            ),
            SizedBox(
              width: 8.h,
            ),
            Text(
              name,
              style: CustomTextStyles.bodyLargeOnPrimaryContainer,
            ),
          ],
        ),
        content,
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
