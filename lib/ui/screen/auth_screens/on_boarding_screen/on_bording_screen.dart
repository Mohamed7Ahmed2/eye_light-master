import 'package:eye_light/modle/introModel.dart';
import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/provider/auth_provider.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/resources/font_manager.dart';
import 'package:eye_light/resources/styles_manager.dart';
import 'package:eye_light/ui/screen/auth_screens/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _IntroPageState();
}

class _IntroPageState extends State<OnBoardingScreen> {
  final List<IntroModle> data = IntroModle.data;
  late PageController _controller;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      setState(() {
        _activeIndex = _controller.page!.round();
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
    builder: (context,provider,x){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(actions:   [
          IconButton(onPressed:(){
             provider.speak(data[_activeIndex].desc);
          },icon: Icon(
            Icons.volume_up,color: ColorManager.black,size: 32.w,),
          )
        ],),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: data.length,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60.h,
                        ),
                        Text(
                          data[_activeIndex].title,
                          style: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s35) ,
                        ),
                        SizedBox(
                          height:_activeIndex==0? 30.h:90.h,
                        ),
                        Padding(
                          padding:   EdgeInsets.symmetric(horizontal: 30.w),
                          child: Text(
                            data[_activeIndex].desc,
                            style: getSemiBoldStyle(color: ColorManager.decOnbording,fontSize: FontSize.s22) ,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width-68.w,
              height: 56.h,
              child: ElevatedButton(onPressed: (){
                provider.tts.stop();
                if (_activeIndex + 1 >= data.length) {
                  RouterClass.routerClass.pushWidgetReplacement(const Splash());
                }
                _controller.nextPage(
                    duration: const Duration(milliseconds: 250), curve: Curves.ease);
              },child: Icon(Icons.arrow_forward,color: ColorManager.white,),),
            ),
            SizedBox(
              height: 93.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 92.w,
                  height: 5.h,
                  color:_activeIndex==0?ColorManager.primary:ColorManager.indecatorBorder  ,
                ),SizedBox(width: 10.w,),
                Container(
                  width: 92.w,
                  height: 5.h,
                  color:_activeIndex==1?ColorManager.primary:ColorManager.indecatorBorder  ,

                ),SizedBox(width: 10.w,),
                Container(
                  width: 92.w,
                  height: 5.h,
                  color:_activeIndex==2?ColorManager.primary:ColorManager.indecatorBorder  ,

                ),SizedBox(width: 10.w,),
              ],
            ),
            SizedBox(height: 42.h,)
          ],
        ),
      );}
    );
  }
}
