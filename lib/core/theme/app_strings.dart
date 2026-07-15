import 'package:flutter/material.dart';
import 'package:spendwise/core/theme/app_colors.dart';

class AppStrings {
  static TextStyle font14grayRegular = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: "Inter",
  );
  static TextStyle font18white700Weight = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontFamily: "Inter",
  );
  static TextStyle font24BlackBoldWeight = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: "Inter",
  );

  static TextStyle font32BlueBold = TextStyle(
    fontSize: 32,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
    fontFamily: "Inter",
  );
}
