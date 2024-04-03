import 'package:boat_rent/data/models/boat_model/boat_model.dart';
import 'package:boat_rent/presentation/main_screen/main_bloc/main_bloc.dart';
import 'package:boat_rent/widgets/app_bar/custom_app_bar.dart';
import 'package:boat_rent/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) => MainBloc()..add(MainGetEvent()),
      child: MainScreen(),
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
            child: Text(
              'Settings',
              style: CustomTextStyles.bodyLargePrimary,
            ),
            onPressed: () {
              NavigatorService.pushNamed(AppRoutes.settingsScreen);
            },
          ),
        ),
        actions: [
          Container(
            width: 85.h,
            child: TextButton(
              child: Text(
                'News',
                style: CustomTextStyles.bodyLargePrimary,
              ),
              onPressed: () {  NavigatorService.pushNamed(AppRoutes.newsScreen);},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is MainLoadedEmptyState) {
                return _emptyScreenBuild(context);
              } else if (state is MainLoadedFullState) {
                return Expanded(child: _fullScreenBuild(context, state));
              } else {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: CustomElevatedButton(
              text: 'Add new transport',
              onPressed: () =>
                  NavigatorService.pushNamed(AppRoutes.newTransportScreen),
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyScreenBuild(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.v,
            ),
            Padding(
              padding: EdgeInsets.all(4.h),
              child: CustomImageView(
                fit: BoxFit.fitWidth,
                imagePath: ImageConstant.imgImg,
              ),
            ),
            SizedBox(
              height: 50.v,
            ),
            Padding(
                padding: EdgeInsets.all(4.h),
                child: Column(
                  children: [
                    Text(
                      'There\'s no info',
                      style: CustomTextStyles.titleLargePrimary,
                    ),
                    SizedBox(
                      height: 8.v,
                    ),
                    Text(
                      'To add your first water transport\nclick on the button below',
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyLargeOnPrimaryContainer,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _fullScreenBuild(BuildContext context, MainLoadedFullState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Main',
              style: theme.textTheme.headlineLarge,
            ),
            SizedBox(
              height: 12.v,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.boatModelList.length,
              itemBuilder: (context, index) {
                return _boatWidgetItem(
                  context,
                  state.boatModelList[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _boatWidgetItem(BuildContext context, BoatModel boatModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      //  padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.surface2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            NavigatorService.pushNamed(AppRoutes.transportInfoScreen,
                arguments: boatModel);
          },
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        boatModel.type,
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 15.v),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          '${boatModel.rentalCost.toInt()}\$ ${boatModel.paymentType.name} ',
                          style: CustomTextStyles.bodyLargeOnPrimaryContainer_2,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowRight,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: 8.v),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: AppDecoration.surface1,
                        height: 30.v,
                        child: Center(
                            child: _transportStateText(
                                context, boatModel.boatState))),
                  ],
                ),
              ],
            ),
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
}
