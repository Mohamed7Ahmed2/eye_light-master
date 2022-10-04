import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/provider/auth_provider.dart';
import 'package:eye_light/resources/assets_manager.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/resources/font_manager.dart';
import 'package:eye_light/resources/styles_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateAccountBlindScreen extends StatelessWidget {
    CreateAccountBlindScreen({Key? key}) : super(key: key);
    GlobalKey<FormState> regFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context,provider1,x){
      return Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          leading: IconButton(onPressed:(){
            RouterClass.routerClass.popFunction();
          },icon: Icon(
            Icons.arrow_back_ios,color: ColorManager.white,size: 32.w,),
          ),
          actions:   [
          IconButton(onPressed:(){

          },icon: Icon(
            Icons.volume_up,color: ColorManager.white,size: 32.w,),
          )
        ],),
        body: Form(
          key: regFormkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity,height: 18.h,),
                Text(
                  'Create an account blind',
                  style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s20) ,
                ),
                 SizedBox(height: 14.h,),
                Container(
                  width: 102.w,
                  height: 102.h,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                     shape: BoxShape.circle
                  ),
                  child: Icon(Icons.person,color: ColorManager.indecatorBorder,size: 45.w,) ,
                ),
                SizedBox(height: 24.h,),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: TextFormField(
                    controller: provider1.firstNameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.next,
                    keyboardType:TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                      fillColor: ColorManager.white,
                      filled: true,
                      hintText: 'First Name',
                      suffixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed:(){
                              provider1.firstNameController.text.isNotEmpty?provider1.speak(provider1.firstNameController.text):provider1.speak('First Name');
                            },icon: Icon(
                              Icons.volume_up,color: ColorManager.black,size: 24.w,),
                            ),
                            IconButton(onPressed:(){
                              provider1.startListeningFirstName();

                            },icon: Icon(
                              Icons.mic,color: ColorManager.black,size: 24.w,),
                            ),
                          ],
                        ),
                      ),
                      hintStyle: getSemiBoldStyle(color: ColorManager.indecatorBorder,fontSize: FontSize.s13),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.white, width: 1.0),
                          borderRadius: BorderRadius.circular(5.r)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(color: ColorManager.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                            color: ColorManager.white, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: const BorderSide(color: Colors.red, width: 1.0),
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 18.h,),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: TextFormField(
                    controller: provider1.lastNameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.next,
                    keyboardType:TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),

                      fillColor: ColorManager.white,
                      filled: true,
                      hintText: 'Last Name',
                      suffixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed:(){
                              provider1.lastNameController.text.isNotEmpty?provider1.speak(provider1.lastNameController.text):provider1.speak('Last Name');

                            },icon: Icon(
                              Icons.volume_up,color: ColorManager.black,size: 24.w,),
                            ),
                            IconButton(onPressed:(){
                              provider1.startListeningLastName();
                            },icon: Icon(
                              Icons.mic,color: ColorManager.black,size: 24.w,),
                            ),
                          ],
                        ),
                      ),
                      hintStyle: getSemiBoldStyle(color: ColorManager.indecatorBorder,fontSize: FontSize.s13),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.white, width: 1.0),
                          borderRadius: BorderRadius.circular(5.r)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(color: ColorManager.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                            color: ColorManager.white, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: const BorderSide(color: Colors.red, width: 1.0),
                      ),
                    ),
                  ),
                ),
                // TextFieldCustom(controller: firstNameController, textInputAction: TextInputAction.next, hint: 'Last name',),
                SizedBox(height: 18.h,),
                Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: TextFormField(
                    controller: provider1.passwordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.next,
                    keyboardType:TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                      fillColor: ColorManager.white,
                      filled: true,
                      hintText: 'Password',
                      suffixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(onPressed:(){
                              provider1.passwordController.text.isNotEmpty?provider1.speak(provider1.passwordController.text):provider1.speak('Password أحمد');
                            },icon: Icon(
                              Icons.volume_up,color: ColorManager.black,size: 24.w,),
                            ),
                            IconButton(onPressed:(){
                              provider1.startListeningPassword();

                            },icon: Icon(
                              Icons.mic,color: ColorManager.black,size: 24.w,),
                            ),
                          ],
                        ),
                      ),
                      hintStyle: getSemiBoldStyle(color: ColorManager.indecatorBorder,fontSize: FontSize.s13),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.white, width: 1.0),
                          borderRadius: BorderRadius.circular(5.r)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(color: ColorManager.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                            color: ColorManager.white, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: const BorderSide(color: Colors.red, width: 1.0),
                      ),
                    ),
                  ),
                ),
                // TextFieldCustom(controller: firstNameController, textInputAction: TextInputAction.next, hint: 'The Language',),
                SizedBox(height: 18.h,),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(5.r)

                  ),
                  child: Column(
                    children: [
                      Text('Enter the fingerprint of the blind ',style: getSemiBoldStyle(color: ColorManager.indecatorBorder,fontSize: FontSize.s14),),
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: ()=>provider1.authenticateREgister(),
                            child: SvgPicture.asset(
                              IconAssets.finger,
                              height: 155.h,
                              width: 110.w,
                              color: ColorManager.indecatorBorder,
                            ),
                          ),
                          Transform.translate(
                             offset: const Offset(0,70),
                             child: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(onPressed:(){
                                    provider1.speak('Enter the fingerprint');
                                  },icon: Icon(
                                    Icons.volume_up,color: ColorManager.black,size: 32.w,),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                 Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      children:  [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r)),
                            checkColor: ColorManager.black,
                            activeColor: ColorManager.indecatorBorder,
                            value: provider1.isCheckLogin,
                            onChanged: (bool? value) {
                              provider1.cahngeIscheckLogin();
                            },
                          ),
                        ),
                        Text('As the responsible person, I agree to the privacy policy',
                            style: getSemiBoldStyle(color: ColorManager.white,
                                fontSize: FontSize.s10.sp)), //Text
                      ],
                    ),
                  ),

                SizedBox(height: 32.h,),
                SizedBox(
                  height: 36.h,
                  child: ElevatedButton(onPressed: (){

                    if (regFormkey.currentState!.validate() && provider1.isCheckLogin) {
                      regFormkey.currentState!.save();
                      provider1.register();
                    } else if(!provider1.isCheckLogin){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('يجب الموافقة علي سياسة الخصوصية',style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 1),

                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:const Text('ادخال خاطئ'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 1),
                          padding: EdgeInsets.only(right: 250.w),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }

                  },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.white,
                       ), child:Text('Create An Account ',style: getBoldStyle(color: ColorManager.indecatorBorder,fontSize: FontSize.s15) ,)
                  ),
                ),
                SizedBox(height: 12.h,),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Really there is an account ?',
                          style: getSemiBoldStyle(color: ColorManager.white,fontSize: FontSize.s10)),
                      TextSpan(
                          text: ' Login',
                          style: getBoldStyle(color: Colors.red,fontSize: FontSize.s10),
                        recognizer:  TapGestureRecognizer()..onTap = () => RouterClass.routerClass.popFunction()

                      ,
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 40.h,),
              ],
            ),
          ),
        ),
      );}
    );
  }
}
// ignore: must_be_immutable
class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {Key? key, required this.controller, required this.textInputAction,required this.hint }) : super(key: key);
  TextEditingController controller;
  final TextInputAction? textInputAction;
  String hint;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
        maxLines: null,
        expands: true,
        textInputAction: textInputAction,
        keyboardType:TextInputType.text,
        decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
          fillColor: ColorManager.white,
          filled: true,
          hintText: hint,
          suffixIcon: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed:(){},icon: Icon(
                  Icons.volume_up,color: ColorManager.black,size: 24.w,),
                ),
                IconButton(onPressed:(){},icon: Icon(
                  Icons.mic,color: ColorManager.black,size: 24.w,),
                ),
              ],
            ),
          ),
          hintStyle: getSemiBoldStyle(color: ColorManager.indecatorBorder,fontSize: FontSize.s13),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorManager.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.r)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: ColorManager.white, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
                color: ColorManager.white, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
        ),
      ),
    );
  }
}
