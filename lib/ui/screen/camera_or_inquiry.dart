import 'dart:io';
import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/resources/font_manager.dart';
import 'package:eye_light/resources/styles_manager.dart';
import 'package:eye_light/ui/screen/record_query_by_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:tflite/tflite.dart';

class CameraOrInquiry extends StatefulWidget {
  const CameraOrInquiry({Key? key}) : super(key: key);

  @override
  State<CameraOrInquiry> createState() => _CameraOrInquiryState();
}

class _CameraOrInquiryState extends State<CameraOrInquiry> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: pickImage,
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
                      Icons.camera_alt,
                      color: ColorManager.black,
                      size: 45.w,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => RouterClass.routerClass
                      .pushWidget(const RecordQueryByVoice()),
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
                    child: Center(
                        child: Text(
                      '?',
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: FontSize.s40),
                    )),
                  ),
                ),
              ],
            ),
            if ((imageSelect))
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.file(_image),
              ),
            Column(
              children: (imageSelect)
                  ? _results.map((result) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 20),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
