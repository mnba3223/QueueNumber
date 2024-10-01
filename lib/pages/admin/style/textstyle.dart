import 'package:flutter/material.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/app_theme.dart';

class AdminTextSetting {
  static Widget admin_table_text_style(String text) {
    return AdminTableText(
      text: text,
    );
  }

  static Widget admin_table_calling_text_style(String text, {Color? color}) {
    return AdminTableText(
      text: text,
      color: color ?? AppColors.primaryColor,
    );
  }

  static Widget admin_subtitle_large_text_style(String text, {Color? color}) {
    return ShopTableText_V2(
      text: text,
      color: color ?? AppColors.CommonText,
    );
  }

  static Widget adminTextStyle(String text,
      {Color? color, FontWeight? fontWeight, double? fontSize}) {
    return AdminTableText(
      text: text,
      fontSize: fontSize ?? AppTheme.themeData.textTheme.bodyLarge?.fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.CommonText,
    );
  }
}

class ShopTableText_V2 extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;

  const ShopTableText_V2(
      {super.key, required this.text, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: color ?? AppColors.CommonText,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

class AdminTableText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const AdminTableText(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: fontSize,
          color: color ?? AppColors.CommonText,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
