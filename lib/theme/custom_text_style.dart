import 'package:flutter/material.dart';
import 'package:boat_rent/core/utils/size_utils.dart';
import 'package:boat_rent/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBluegray900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get bodyLargeDeeporange800 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.deepOrange800,
      );
  static get bodyLargeErrorContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get bodyLargeInterGray70087 =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.gray70087,
      );
  static get bodyLargeOnPrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodyLargeOnPrimaryContainer_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.55),
      );
  static get bodyLargeOnPrimaryContainer_2 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.53),
      );
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyLargeRed800 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.red800,
      );
  static get bodyLargeSFProDisplayOnPrimaryContainer =>
      theme.textTheme.bodyLarge!.sFProDisplay.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.53),
      );
  static get bodyLargeSecondaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static get bodyLargefffff5f2 => theme.textTheme.bodyLarge!.copyWith(
        color: Color(0XFFFFF5F2),
      );
  // Headline text style
  static get headlineLargeSemiBold => theme.textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleMediumInter => theme.textTheme.titleMedium!.inter.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterGray200 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.gray200,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }

  TextStyle get sFProDisplay {
    return copyWith(
      fontFamily: 'SF Pro Display',
    );
  }
}
