import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/utils/Colors.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            // fontSize: 24,
            fontSize: 15.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.DisplayLargeText),
        displayMedium: TextStyle(
            // fontSize: 24,
            fontSize: 11.5.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.DisplayLargeText),
        titleLarge: TextStyle(
            // fontSize: 24,
            fontSize: 6.8.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        titleMedium: TextStyle(
            // fontSize: 24,
            fontSize: 6.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        headlineLarge: TextStyle(
            // fontSize: 24,
            fontSize: 11.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        headlineSmall: TextStyle(
            // fontSize: 24,
            fontSize: 8.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.CommonText),
        bodyLarge: TextStyle(
            fontSize: 5.9.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.neutral50),
        bodyMedium: TextStyle(
            fontSize: 5.8.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.neutral50),
        bodySmall: TextStyle(
            // fontSize: 24,
            fontSize: 5.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
        labelLarge: TextStyle(
            fontSize: 7.2.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.White),
      ),
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      cardColor: AppColors.backgroundColor,
      cardTheme: CardTheme(
        color: AppColors.backgroundColor,
      ),
      // primaryTextTheme: textTheme,
      colorScheme: customScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          // foregroundColor: AppColors.White,
          shadowColor: Colors.transparent,
          // shape: const StadiumBorder(),
        ),
      ),
      buttonTheme: ButtonThemeData(
          // buttonColor: AppColors.primaryColor,
          // textTheme: ButtonTextTheme.primary,
          ),
    );
  }
}

// TextTheme textTheme = TextTheme(
//   displayLarge: TextStyle(
//       // fontSize: 24,
//       fontSize: 15.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.DisplayLargeText),
//   titleLarge: TextStyle(
//       // fontSize: 24,
//       fontSize: 6.8.sp,
//       fontWeight: FontWeight.bold,
//       color: AppColors.primaryColor),
//   titleMedium: TextStyle(
//       // fontSize: 24,
//       fontSize: 6.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.primaryColor),
//   headlineLarge: TextStyle(
//       // fontSize: 24,
//       fontSize: 11.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.primaryColor),
//   bodyLarge: TextStyle(
//       fontSize: 6.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.neutral50),
//   bodyMedium: TextStyle(
//       fontSize: 5.8.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.neutral50),
//   bodySmall: TextStyle(
//       // fontSize: 24,
//       fontSize: 5.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.primaryColor),
//   labelLarge: TextStyle(
//       fontSize: 6.8.sp,
//       // fontWeight: FontWeight.bold,
//       color: AppColors.White),
// );

ColorScheme baseScheme = ColorScheme.fromSeed(
  seedColor: AppColors.primaryColor,
  // primarySwatch: Colors.blue,
);

ColorScheme customScheme = baseScheme.copyWith(
  primary: AppColors.primaryColor,
  // secondary: AppColors.secondary10,
  // primaryContainer: AppColors.primaryColor,
  // 你可以根据需要修改其他颜色
);

// ColorScheme? colorScheme = ColorScheme(
//   primary: AppColors.primaryColor,
//   primaryContainer: AppColors.primaryColor,
//   secondary: AppColors.secondary10,
//   // secondaryContainer: AppColors.secondary10,
//   surface: Colors.white,
//   background: Colors.white,
//   error: Colors.red,
//   onPrimary: Colors.white,
//   onSecondary: Colors.white,
//   onSurface: Colors.black,
//   onBackground: Colors.black,
//   onError: Colors.white,
//   brightness: Brightness.light,
//   // accentColor: Colors.green,
//   // 其他主題設置...
// );
