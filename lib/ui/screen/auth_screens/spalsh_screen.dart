import 'dart:async';
import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/resources/assets_manager.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/ui/screen/auth_screens/login_as_blind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    Future.delayed(const Duration(seconds: 3)).then((v) async {
      // User? user =FirebaseAuth.instance.currentUser;
      //
      // if (user == null) {
        RouterClass.routerClass.pushWidgetRemovePrev(const LoginBlindScreen());
      // } else {
      //   RouterClass.routerClass.pushWidget(const CameraOrInquiry());
      // }
    });
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(actions:[
        IconButton(onPressed:(){},icon: Icon(
          Icons.volume_up,color: ColorManager.black,size: 32.w,),
        )
      ],),
      body:
      Center(child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          height: 309.h,
          child:Image.asset(ImageAssets.splashImage)
      )),
    );
  }
}

