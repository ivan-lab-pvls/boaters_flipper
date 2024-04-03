import 'package:flutter/material.dart';
import 'package:boat_rent/core/app_export.dart';

class AppDecoration {
  // Surface decorations
  static BoxDecoration get surface1 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
    borderRadius: BorderRadius.circular(5),
      );
  static BoxDecoration get infoSurf => BoxDecoration(
    color: theme.colorScheme.onPrimary,
    borderRadius: BorderRadius.circular(5),
  );

  static BoxDecoration get surface2 => BoxDecoration(
        color: appTheme.blueGray900,
      );

  static BoxDecoration get circle => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(30),
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );

  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
