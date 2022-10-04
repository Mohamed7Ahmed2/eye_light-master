// import 'package:eye_light/navigator/router_class.dart';
// import 'package:eye_light/provider/record_provider.dart';
// import 'package:eye_light/resources/assets_manager.dart';
// import 'package:eye_light/resources/color_manager.dart';
// import 'package:eye_light/ui/screen/camera_or_inquiry.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:io';
// import 'package:eye_light/ui/tettt.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
// class RecordSecreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorManager.white,
//         actions:   [
//           IconButton(onPressed:(){},icon: Icon(
//             Icons.mic,color: ColorManager.black,size: 32.w,),
//           ),
//           SizedBox(width: 10.w,),
//           GestureDetector(
//               onTap: ()=>RouterClass.routerClass.pushWidget(const CameraOrInquiry()) ,
//               child: SvgPicture.asset(IconAssets.errorIcon)),
//           SizedBox(width: 10.w,)
//         ],),
//
//       body: Consumer<RecordProvider>(
//         builder: (context,provider,x){
//         return Container(
//           width: double.infinity,
//           decoration:const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(ImageAssets.backgrounImage),fit: BoxFit.fill
//             )
//           ),
//           child: Column(
//             children: [
//               SizedBox(height: 100.h,),
//
//               if (provider.playerController5.playerState != PlayerState.stopped) ...[
//                 WaveBubble(
//                   playerController: provider.playerController5,
//                   isPlaying: provider.playerController5.playerState == PlayerState.playing,
//                   onTap: () => provider.playOrPausePlayer(provider.playerController5),
//                   isSender: true,
//                 ),
//               ],
//               const Spacer(),
//               GestureDetector(
//                 onTap: ()=>provider.startOrStopRecording(),
//                 child:provider.isRecording?AudioWaveforms(
//                   enableGesture: true,
//                   size:
//                   Size(MediaQuery.of(context).size.width / 2, 50),
//                   recorderController: provider.recorderController,
//                   waveStyle: const WaveStyle(
//                     waveColor: Colors.white,
//                     extendWaveform: true,
//                     showMiddleLine: false,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.0),
//                     color: const Color(0xFF1E1B26),
//                   ),
//                   padding: const EdgeInsets.only(left: 18),
//                   margin: const EdgeInsets.symmetric(horizontal: 15),
//                 ): Container(
//                   width: 180.w,
//                   height: 180.h,
//                     margin: EdgeInsets.only(bottom: 16.h),
//                     padding: EdgeInsets.all(50.w),
//                   decoration: BoxDecoration(
//                     color: ColorManager.white,
//                     shape: BoxShape.circle
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorManager.indecatorBorder,
//                         shape: BoxShape.circle
//                        , boxShadow: [
//                     BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2), // changes position of shadow
//                   ),
//                   ],
//                     ),
//
//
//                   ),
//                 ),
//               )
//
//             ],
//           ),
//         );}
//       ),
//     );
//     }
//
//   void _modalBottomSheetMenu(BuildContext context){
//     showModalBottomSheet(
//         context: context,
//         builder: (builder){
//           return   Container(
//             height: 250.h,
//             color: Colors.transparent,
//             child: Container(
//                 decoration:   BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(50.r),
//                         topRight: Radius.circular(50.r))
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 20.h,),
//                     Container(
//                       width: 97.w,
//                       height: 3.h,
//                       color: ColorManager.indecatorBorder,
//                     ),
//                     Container(
//                       width: 269.w,
//                       height: 169,
//                       margin: EdgeInsets.symmetric(vertical: 20.h),
//                       decoration:const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(ImageAssets.recordStart),fit: BoxFit.fill
//                           )
//                       ),
//                     )
//                   ],
//                 )
//             ),
//           );
//         },
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
//       ),
//     );
//   }
// }
// //
// // class Home extends StatefulWidget {
// //   const Home({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Home> createState() => _HomeState();
// // }
// //
// // class _HomeState extends State<Home> with WidgetsBindingObserver {
// //   late final RecorderController recorderController;
// //
// //   late final PlayerController playerController5;
// //
// //   // late final PlayerController playerController6;
// //
// //   String? path;
// //   String? musicFile;
// //   bool isRecording = false;
// //
// //   // late Directory appDirectory;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // _getDir();
// //     _initialiseControllers();
// //   }
// //
// //   void _initialiseControllers() {
// //     recorderController = RecorderController()
// //       ..androidEncoder = AndroidEncoder.aac
// //       ..androidOutputFormat = AndroidOutputFormat.mpeg4
// //       ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
// //       ..sampleRate = 16000
// //       ..bitRate = 64000;
// //
// //     playerController5 = PlayerController()
// //       ..addListener(() {
// //         if (mounted) setState(() {});
// //       });
// //   }
// //
// //   void _disposeControllers() {
// //     recorderController.dispose();
// //
// //     playerController5.dispose();
// //     // playerController6.dispose();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _disposeControllers();
// //     super.dispose();
// //   }
// //
// //   ///As recording/playing media is resource heavy task,
// //   ///you don't want any resources to stay allocated even after
// //   ///app is killed. So it is recommended that if app is directly killed then
// //   ///this still will be called and we can free up resouces.
// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     if (state == AppLifecycleState.detached) {
// //       _disposeControllers();
// //     }
// //     super.didChangeAppLifecycleState(state);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF252331),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF252331),
// //         elevation: 1,
// //         centerTitle: true,
// //         shadowColor: Colors.grey,
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: const [
// //             Icon(Icons.offline_bolt),
// //             SizedBox(width: 10),
// //             Text('Simform'),
// //           ],
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 20),
// //             if (playerController5.playerState != PlayerState.stopped) ...[
// //               WaveBubble(
// //                 playerController: playerController5,
// //                 isPlaying: playerController5.playerState == PlayerState.playing,
// //                 onTap: () => _playOrPausePlayer(playerController5),
// //                 isSender: true,
// //               ),
// //             ],
// //             // if (playerController6.playerState != PlayerState.stopped) ...[
// //             //   WaveBubble(
// //             //     playerController: playerController6,
// //             //     isPlaying: playerController6.playerState == PlayerState.playing,
// //             //     onTap: () => _playOrPausePlayer(playerController6),
// //             //     isSender: true,
// //             //   ),
// //             // ],
// //             const Spacer(),
// //             SafeArea(
// //               child: Row(
// //                 children: [
// //                   AnimatedSwitcher(
// //                     duration: const Duration(milliseconds: 200),
// //                     child: isRecording
// //                         ? AudioWaveforms(
// //                       enableGesture: true,
// //                       size:
// //                       Size(MediaQuery.of(context).size.width / 2, 50),
// //                       recorderController: recorderController,
// //                       waveStyle: const WaveStyle(
// //                         waveColor: Colors.white,
// //                         extendWaveform: true,
// //                         showMiddleLine: false,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(12.0),
// //                         color: const Color(0xFF1E1B26),
// //                       ),
// //                       padding: const EdgeInsets.only(left: 18),
// //                       margin: const EdgeInsets.symmetric(horizontal: 15),
// //                     )
// //                         : Container(
// //                       width: MediaQuery.of(context).size.width / 1.7,
// //                       height: 50,
// //                       decoration: BoxDecoration(
// //                         color: const Color(0xFF1E1B26),
// //                         borderRadius: BorderRadius.circular(12.0),
// //                       ),
// //                       padding: const EdgeInsets.only(left: 18),
// //                       margin: const EdgeInsets.symmetric(horizontal: 15),
// //                       child: const TextField(
// //                         readOnly: true,
// //                         decoration: InputDecoration(
// //                           hintText: "Type Something...",
// //                           hintStyle: TextStyle(color: Colors.white54),
// //                           contentPadding: EdgeInsets.only(top: 16),
// //                           border: InputBorder.none,
// //                           // suffixIcon: IconButton(
// //                           //   onPressed: _pickFile,
// //                           //   icon: Icon(Icons.adaptive.share),
// //                           //   color: Colors.white54,
// //                           // ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   IconButton(
// //                     onPressed: _refreshWave,
// //                     icon: Icon(
// //                       isRecording ? Icons.refresh : Icons.send,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   IconButton(
// //                     onPressed: _startOrStopRecording,
// //                     icon: Icon(isRecording ? Icons.stop : Icons.mic),
// //                     color: Colors.white,
// //                     iconSize: 28,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _playOrPausePlayer(PlayerController controller) async {
// //     controller.playerState == PlayerState.playing
// //         ? await controller.pausePlayer()
// //         : await controller.startPlayer(finishMode: FinishMode.loop);
// //   }
// //
// //   void _startOrStopRecording() async {
// //     if (isRecording) {
// //       recorderController.reset();
// //       final path = await recorderController.stop(false);
// //       if (path != null) {
// //         debugPrint('oamr');
// //         debugPrint("Recorded file size: ${File(path).lengthSync()}");
// //         await playerController5.preparePlayer(path);
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //         debugPrint('end');
// //       }
// //     } else {
// //       await recorderController.record(path);
// //     }
// //     setState(() {
// //       isRecording = !isRecording;
// //     });
// //   }
// //
// //
// //   void _refreshWave() {
// //     if (isRecording) {
// //       recorderController.refresh();
// //     }
// //   }
// // }
