import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTextStyle {
  static final TextStyle primaryTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColor.textColor,
  );

  static final TextStyle primaryButtonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColor.background,
  );

  static final TextStyle secondaryStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.textColor,
  );

  static final TextStyle secondaryStyleAsk = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.primaryGray,
  );

  static final TextStyle itemStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.textColor,
  );

  static final TextStyle itemStylePrice = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.primaryColor,
  );

  static final TextStyle primaryStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.textColor,
  );
}