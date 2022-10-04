import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/resources/font_manager.dart';
import 'package:eye_light/resources/styles_manager.dart';
import 'package:eye_light/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: ColorManager.primary,
    // ScafolledColor
    scaffoldBackgroundColor: ColorManager.white,
    //TextTheme
    textTheme: TextTheme(
      headline1: getBoldStyle(color: ColorManager.black),
      headline2: getMediumStyle(color: ColorManager.black),
      headline3: getRegularStyle(color: ColorManager.black),
      headline4: getLightStyle(color: ColorManager.black),
    ),
    //CardTheme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: Colors.grey,
      elevation: AppSize.s4),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.white,
        elevation: 0,
         titleTextStyle:
            getBoldStyle(fontSize: FontSize.s16, color: ColorManager.black)),
    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: Colors.grey,
        buttonColor: ColorManager.primary,
        ),
    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s40.sp),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s5)))),

  );
}
