import 'package:boat_rent/data/models/boat_model/boat_model.dart';
import 'package:boat_rent/data/models/news_model/news_model.dart';
import 'package:boat_rent/presentation/main_screen/main_screen.dart';
import 'package:boat_rent/presentation/new_transport_screen/new_transport_screen.dart';
import 'package:boat_rent/presentation/news_content_screen/news_content_screen.dart';
import 'package:boat_rent/presentation/news_screen/news_screen.dart';
import 'package:boat_rent/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:boat_rent/presentation/onboarding_screen/start_info_screen.dart';
import 'package:boat_rent/presentation/settings_screen/settings_screen.dart';
import 'package:boat_rent/presentation/transport_info_screen/transport_info_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';
  static const String startInfoScreen = '/start_info_screen';
  static const String newTransportScreen = '/new_transport_screen';
  static const String mainScreen = '/main_screen';
  static const String transportInfoScreen = '/transport_info_screen';
  static const String settingsScreen = '/settings_screen';
  static const String newsScreen = '/news_screen';
  static const String newsContentScreen = '/news_content_screen';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: OnboardingScreen.builder,
        startInfoScreen: StartInfoScreen.builder,
        mainScreen: MainScreen.builder,
        newTransportScreen: NewTransportScreen.builder,
        transportInfoScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as BoatModel;
          return TransportInfoScreen.builder(context, arguments);
        },
        newsContentScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as NewsModel;
          return NewsContentScreen.builder(context, arguments);
        },
        settingsScreen: SettingsScreen.builder,
        newsScreen: NewsScreen.builder,
      };
}
