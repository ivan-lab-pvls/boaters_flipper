import 'package:boat_rent/widgets/app_bar/custom_app_bar.dart';
import 'package:boat_rent/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../core/app_export.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static Widget builder(BuildContext context) {
    return SettingsScreen();
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Settings',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 12.v,
              ),
              Container(
                padding: EdgeInsets.all(16.h),
                decoration: AppDecoration.surface2.copyWith(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomImageView(
                      fit: BoxFit.fitWidth,
                      imagePath: ImageConstant.img5375344Yacht1,
                    ),
                    SizedBox(
                      height: 50.v,
                    ),
                    Text(
                      'Your opinion is important!',
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 12.v,
                    ),
                    Text(
                      'We need your feedback to get better',
                      style: CustomTextStyles.bodyLargeOnPrimaryContainer_2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.v,
                    ),
                    CustomElevatedButton(
                      text: 'Rate app',
                      onPressed: () {
                        InAppReview.instance
                            .openStoreListing(appStoreId: '6480523938');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.v,
              ),
              _buildButton(context,
                  name: 'Terms of use',
                  imagePath: ImageConstant.imgPaper, onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ReadTerms(
                            dataFox:
                                'https://docs.google.com/document/d/1LEn9sR1wWyYob5xVxLtKoXj_u8tBTREjrYavuiPLpWM/edit?usp=sharing',
                          )),
                );
              }),
              SizedBox(
                height: 12.v,
              ),
              _buildButton(context,
                  name: 'Privacy Policy',
                  imagePath: ImageConstant.imgPrivacyOnprimarycontainer,
                  onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ReadTerms(
                            dataFox:
                                'https://docs.google.com/document/d/1SoBJaq7xiqSif5CNwM2_VMolhl6at-w8CZaHNr2nPDE/edit?usp=sharing',
                          )),
                );
              }),
              SizedBox(
                height: 12.v,
              ),
              _buildButton(context,
                  name: 'Support page',
                  imagePath: ImageConstant.imgNotes, onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ReadTerms(
                            dataFox: 'https://forms.gle/zn2rRjdWtFUxbaYQ8',
                          )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {String imagePath = '', String name = '', Function()? onTap}) {
    return Container(
      decoration: AppDecoration.surface2.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            onTap?.call();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: imagePath,
                ),
                SizedBox(
                  width: 8.v,
                ),
                Expanded(
                    child: Text(
                  name,
                  style: CustomTextStyles.bodyLargeOnPrimaryContainer_2,
                )),
                Icon(
                  Icons.arrow_forward_ios,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReadTerms extends StatelessWidget {
  final String dataFox;

  const ReadTerms({Key? key, required this.dataFox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 55, 45),
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(dataFox)),
        ),
      ),
    );
  }
}
