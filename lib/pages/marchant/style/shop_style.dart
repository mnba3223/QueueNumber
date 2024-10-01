import 'package:flutter/material.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/app_theme.dart';

///Create mutiple Text style for shop page

class ShopTextSetting {
  static Widget shop_table_text_style(String text) {
    return ShopTableText(
      text: text,
    );
  }

  static Widget shop_table_calling_text_style(String text, {Color? color}) {
    return ShopTableText(
      text: text,
      color: color ?? AppColors.primaryColor,
    );
  }

  static Widget shop_headerline_large_text_style(String text, {Color? color}) {
    return ShopTableText_V2(
      text: text,
      color: color ?? AppColors.CommonText,
    );
  }

  static Widget shop_title_medium_text_style(String text, {Color? color}) {
    return ShopTableText(
      text: text,
      fontSize: AppTheme.themeData.textTheme.titleMedium?.fontSize,
      fontWeight: FontWeight.bold,
      color: color ?? AppColors.primaryColor,
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

class ShopTableText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const ShopTableText(
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
