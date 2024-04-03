import 'package:boat_rent/core/app_export.dart';
import 'package:boat_rent/presentation/news_screen/news_screen.dart';
import 'package:flutter/material.dart';

import '../../data/models/news_model/news_model.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class NewsContentScreen extends StatefulWidget {
  final NewsModel newsModel;

  const NewsContentScreen({super.key, required this.newsModel});

  static Widget builder(BuildContext context, NewsModel newsModel) {
    return NewsContentScreen(
      newsModel: newsModel,
    );
  }

  @override
  State<NewsContentScreen> createState() => _NewsContentScreenState();
}

class _NewsContentScreenState extends State<NewsContentScreen> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
            child: Text(
              'News',
              style: theme.textTheme.headlineLarge,
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
                child: Column(
                  children: [
                   // SizedBox(height: 13.v),
                    CustomImageView(
                        fit: BoxFit.cover,
                        imagePath: widget.newsModel.imgUrl,
                        // height: 178.v,
                        radius: BorderRadius.circular(4.h)),
                    SizedBox(height: 20.v),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            //width: 62.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.h, vertical: 2.v),
                            decoration: AppDecoration.surface2.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder4),
                            child: Text(
                                DateTimeParser.parseDateTime(
                                    widget.newsModel.date!),
                                style: CustomTextStyles.bodyLargePrimary))),
                    SizedBox(height: 20.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.newsModel.title!,
                            style: theme.textTheme.titleLarge)),
                    SizedBox(height: 20.v),
                    Container(
                      //  width: 334.h,
                      margin: EdgeInsets.only(right: 8.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: widget.newsModel.body,
                                style: CustomTextStyles
                                    .bodyLargeOnPrimaryContainer_2),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
