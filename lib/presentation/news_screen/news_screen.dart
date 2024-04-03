import 'package:boat_rent/core/app_export.dart';
import 'package:boat_rent/data/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/news_model/news_model.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  static Widget builder(BuildContext context) {
    return NewsScreen();
  }

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> newsModelList = [];

  @override
  void initState() {
    // TODO: implement initState
    newsModelList = DataManager.getAllNews();
    super.initState();
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    return _newsItemBuild(
                      context,
                      newsModelList[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _newsItemBuild(BuildContext context, NewsModel newsModel) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.v,
      ),
      decoration: AppDecoration.surface2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            NavigatorService.pushNamed(AppRoutes.newsContentScreen,
                arguments: newsModel);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.v, horizontal: 6.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: newsModel.imgUrl,
                  height: 98.adaptSize,
                  width: 98.adaptSize,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(
                    8.h,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 3.v),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.v, left: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            //  width: 62.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.h,
                              vertical: 2.v,
                            ),
                            decoration: AppDecoration.surface1.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder4,
                            ),
                            child: Text(
                              DateTimeParser.parseDateTime(newsModel.date!),
                              style: CustomTextStyles.bodyLargePrimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 22.v),
                        SizedBox(
                          //width: 178.h,
                          child: Text(
                            newsModel.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge!.copyWith(
                              height: 1.20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimeParser {
  static String parseDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'Today';
    } else {
      return DateFormat('MMMM d').format(dateTime);
    }
  }
}
