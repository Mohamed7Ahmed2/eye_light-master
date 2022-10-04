import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/resources/font_manager.dart';
import 'package:eye_light/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordQueryByVoice extends StatefulWidget {
  const RecordQueryByVoice({Key? key}) : super(key: key);

  @override
  State<RecordQueryByVoice> createState() => _RecordQueryByVoiceState();
}

class _RecordQueryByVoiceState extends State<RecordQueryByVoice> {
  // final recorder = FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    initREcorder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future initREcorder() async {
    // final status = await Permission.microphone.request();
    // if (status != PermissionStatus.granted) {
      throw 'Microphone Permission not granted';
    }


  Future record() async {
    // await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    // await recorder.stopRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          onPressed: () {
            RouterClass.routerClass.popFunction();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorManager.white,
            size: 32.w,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.volume_up,
              color: ColorManager.white,
              size: 32.w,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Text(
            'Send An Inquiry',
            style: getSemiBoldStyle(
                color: ColorManager.white, fontSize: FontSize.s35),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              // if (recorder.isRecording) {
              //   await stop();
              // } else {
              //   await record();
              // }
              setState(() {});
            },
            child: Container(
              width: 145.w,
              height: 145.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.4),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      2,
                    ),
                  ),
                ],
              ),
              child: Icon(
                Icons.mic,
                color: ColorManager.black,
                size: 45.w,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
