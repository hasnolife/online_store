import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';

abstract class AppTextStyles {
  static const HeaderTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    letterSpacing: -0.33,
  );
  static const LinkedHeaderTextStyle =
      TextStyle(fontSize: 15, color: AppColors.orange);
  static const HeaderCategoryTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);
  static const SelectedHeaderCategoryTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.orange);

  static const DetailsHeaderTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);

  static const DetailsProductNameTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.33,
      color: AppColors.dark);


}
