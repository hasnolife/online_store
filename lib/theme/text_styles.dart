import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';

abstract class AppTextStyles {
  static const linkedHeaderTextStyle =
      TextStyle(fontSize: 15, color: AppColors.orange);

  static const headerCategoryTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);

  static const headerTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    letterSpacing: -0.33,
  );

  static const cartSummaryTitleTextStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.33,
      color: AppColors.white);
}
