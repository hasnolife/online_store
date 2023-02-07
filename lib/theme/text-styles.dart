import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';

abstract class AppTextStyles {
  static const headerTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    letterSpacing: -0.33,
  );

  static const linkedHeaderTextStyle =
      TextStyle(fontSize: 15, color: AppColors.orange);

  static const headerCategoryTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);
  static const selectedHeaderCategoryTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.orange);

  static const detailsHeaderTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);

  static const detailsProductNameTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);

  static const cartHeaderTextStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);

  static const cartTitleTextStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    letterSpacing: -0.33,
  );
  static const cartButtonTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.33,
  );

  static const cartSummaryTitleTextStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.33,
      color: AppColors.white);

  static const cartSummaryValueTextStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.33,
      color: AppColors.white);

  static const cartProductTitleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.white);

  static const cartProductPriceTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.red);
}
