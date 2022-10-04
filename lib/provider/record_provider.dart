//
// import 'dart:io';
//
// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:flutter/material.dart';
//
// class RecordProvider extends ChangeNotifier{
//   RecordProvider() {
//     initialiseControllers();
//   }
//
//   void initialiseControllers() {
//     recorderController = RecorderController()
//       ..androidEncoder = AndroidEncoder.aac
//       ..androidOutputFormat = AndroidOutputFormat.mpeg4
//       ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
//       ..sampleRate = 16000
//       ..bitRate = 64000;
//
//     playerController5 = PlayerController();
//   }
//   late final RecorderController recorderController;
//   late final PlayerController playerController5;
//
//   bool isRecording = false;
//   String? path1;
//   void playOrPausePlayer(PlayerController controller) async {
//     controller.playerState == PlayerState.playing
//         ? await controller.pausePlayer()
//         : await controller.startPlayer(finishMode: FinishMode.loop);
//   }
//
//   void startOrStopRecording() async {
//     if (isRecording) {
//       recorderController.reset();
//       final path = await recorderController.stop(false);
//       if (path != null) {
//         debugPrint("Recorded file size: ${File(path).lengthSync()}");
//         await playerController5.preparePlayer(path);
//         debugPrint('end');
//       }
//     } else {
//       await recorderController.record();
//     }
//       isRecording = !isRecording;
//     notifyListeners();
//   }
//
//
//   void refreshWave() {
//     if (isRecording) {
//       recorderController.refresh();
//     }
//     notifyListeners();
//   }
// }