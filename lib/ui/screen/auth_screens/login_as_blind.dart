import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/provider/auth_provider.dart';
import 'package:eye_light/resources/assets_manager.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/resources/font_manager.dart';
import 'package:eye_light/resources/styles_manager.dart';
import 'package:eye_light/ui/screen/auth_screens/create_acount_blind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginBlindScreen extends StatelessWidget {
  const LoginBlindScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context,provider,x){
          return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(actions:   [
          IconButton(onPressed:(){
            provider.speak('login as Blind');
          },icon: Icon(
            Icons.volume_up,color: ColorManager.black,size: 32.w,),
          )
        ],),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity,height: 100.h,),
            Text(
              'login as Blind',
              style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s40) ,
            ),
            SizedBox(height: 66.h,),
            GestureDetector(
              onTap: provider.authenticate,
              child: SizedBox(
                width: 125.w,
                height: 175.h,
                child: SvgPicture.asset(
                  IconAssets.finger,
                  height: 25.h,
                  width: 25.w,
                  color: ColorManager.black,
                ),
              ),
            ),
            SizedBox(height: 43.h,),
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 55.w),
              child: Text('I\'m the one responsible and he doesn\'t have an account yet',
                style: getRegularStyle(color: ColorManager.black2,fontSize: FontSize.s18),
              textAlign: TextAlign.center,
              ),
            ),
            TextButton(onPressed: (){
              RouterClass.routerClass.pushWidget(  CreateAccountBlindScreen());

            }, child: Text('Create an account',style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s18),))

          ],
        ),
      );}
    );
  }
}
