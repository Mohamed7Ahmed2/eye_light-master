import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/provider/auth_provider.dart';
import 'package:eye_light/resources/theme_manager.dart';
import 'package:eye_light/ui/screen/auth_screens/on_boarding_screen/on_bording_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      // ChangeNotifierProvider<RecordProvider>(create: (_) => RecordProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: RouterClass.routerClass.navKey,
            scaffoldMessengerKey:
                RouterClass.routerClass.rootScaffoldMessengerKey,
            theme: getApplicationTheme(),
            home: child,
          );
        },
        child: const OnBoardingScreen());
  }
}
//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// void main() => runApp(SpeechSampleApp());
//
// class SpeechSampleApp extends StatefulWidget {
//   @override
//   _SpeechSampleAppState createState() => _SpeechSampleAppState();
// }
//
// /// An example that demonstrates the basic functionality of the
// /// SpeechToText plugin for using the speech recognition capability
// /// of the underlying platform.
// class _SpeechSampleAppState extends State<SpeechSampleApp> {
//   bool _hasSpeech = false;
//   bool _logEvents = false;
//   final TextEditingController _pauseForController =
//   TextEditingController(text: '3');
//   final TextEditingController _listenForController =
//   TextEditingController(text: '30');
//   double level = 0.0;
//   double minSoundLevel = 50000;
//   double maxSoundLevel = -50000;
//   String lastWords = '';
//   String lastError = '';
//   String lastStatus = '';
//   String _currentLocaleId = '';
//   List<LocaleName> _localeNames = [];
//   final SpeechToText speech = SpeechToText();

//   @override
//   void initState() {
//     super.initState();
//     initSpeechState();
//   }
//
//   /// This initializes SpeechToText. That only has to be done
//   /// once per application, though calling it again is harmless
//   /// it also does nothing. The UX of the sample app ensures that
//   /// it can only be called once.
//   Future<void> initSpeechState() async {
//     _logEvent('Initialize');
//     try {
//       var hasSpeech = await speech.initialize(
//         onError: errorListener,
//         onStatus: statusListener,
//         debugLogging: true,
//       );
//       if (hasSpeech) {
//         // Get the list of languages installed on the supporting platform so they
//         // can be displayed in the UI for selection by the user.
//         _localeNames = await speech.locales();
//
//         var systemLocale = await speech.systemLocale();
//         _currentLocaleId = systemLocale?.localeId ?? '';
//       }
//       if (!mounted) return;
//
//       setState(() {
//         _hasSpeech = hasSpeech;
//       });
//     } catch (e) {
//       setState(() {
//         lastError = 'Speech recognition failed: ${e.toString()}';
//         _hasSpeech = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Speech to Text Example'),
//         ),
//         body: Column(children: [
//           const Text(
//             'Speech recognition available',
//             style: TextStyle(fontSize: 22.0),
//           ),
//           Container(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     TextButton(
//                       onPressed: _hasSpeech ? null : initSpeechState,
//                       child: const Text('Initialize'),
//                     ),
//                   ],
//                 ),
//                 // InitSpeechWidget(_hasSpeech, initSpeechState),
//                 SpeechControlWidget(_hasSpeech, speech.isListening,
//                     startListening, stopListening, cancelListening),
//                 SessionOptionsWidget(
//                   _currentLocaleId,
//                   _switchLang,
//                   _localeNames,
//                   _logEvents,
//                   _switchLogging,
//                   _pauseForController,
//                   _listenForController,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: RecognitionResultsWidget(lastWords: lastWords, level: level),
//           ),
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: <Widget>[
//                 const Center(
//                   child: Text(
//                     'Error Status',
//                     style: TextStyle(fontSize: 22.0),
//                   ),
//                 ),
//                 Center(
//                   child: Text(lastError),
//                 ),
//               ],
//             )
//             // ErrorWidget(lastError: lastError),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             color: Theme.of(context).backgroundColor,
//             child: Center(
//               child: speech.isListening
//                   ? const Text(
//                 "I'm listening...",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               )
//                   : const Text(
//                 'Not listening',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           )
//
//           // SpeechStatusWidget(speech: speech),
//         ]),
//       ),
//     );
//   }
//
//   // This is called each time the users wants to start a new speech
//   // recognition session
//   void startListening() {
//     _logEvent('start listening');
//     lastWords = '';
//     lastError = '';
//     final pauseFor = int.tryParse(_pauseForController.text);
//     final listenFor = int.tryParse(_listenForController.text);

//     speech.listen(
//         onResult: resultListener,
//         listenFor: Duration(seconds: listenFor ?? 30),
//         pauseFor: Duration(seconds: pauseFor ?? 3),
//         partialResults: true,
//         localeId: _currentLocaleId,
//         onSoundLevelChange: soundLevelListener,
//         cancelOnError: true,
//         listenMode: ListenMode.confirmation);
//     setState(() {});
//   }
//
//   void stopListening() {
//     _logEvent('stop');
//     speech.stop();
//     setState(() {
//       level = 0.0;
//     });
//   }
//
//   void cancelListening() {
//     _logEvent('cancel');
//     speech.cancel();
//     setState(() {
//       level = 0.0;
//     });
//   }
//
//   /// This callback is invoked each time new recognition results are
//   /// available after `listen` is called.
//   void resultListener(SpeechRecognitionResult result) {
//     _logEvent(
//         'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
//     setState(() {
//       lastWords = '${result.recognizedWords} - ${result.finalResult}';
//     });
//   }
//
//   void soundLevelListener(double level) {
//     minSoundLevel = min(minSoundLevel, level);
//     maxSoundLevel = max(maxSoundLevel, level);
//     // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
//     setState(() {
//       this.level = level;
//     });
//   }
//
//   void errorListener(SpeechRecognitionError error) {
//     _logEvent(
//         'Received error status: $error, listening: ${speech.isListening}');
//     setState(() {
//       lastError = '${error.errorMsg} - ${error.permanent}';
//     });
//   }
//
//   void statusListener(String status) {
//     _logEvent(
//         'Received listener status: $status, listening: ${speech.isListening}');
//     setState(() {
//       lastStatus = '$status';
//     });
//   }
//
//   void _switchLang(selectedVal) {
//     setState(() {
//       _currentLocaleId = selectedVal;
//     });
//     print(selectedVal);
//   }
//
//   void _logEvent(String eventDescription) {
//     if (_logEvents) {
//       var eventTime = DateTime.now().toIso8601String();
//       print('$eventTime $eventDescription');
//     }
//   }
//
//   void _switchLogging(bool? val) {
//     setState(() {
//       _logEvents = val ?? false;
//     });
//   }
// }
//
// /// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
  }) : super(key: key);

  final String lastWords;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Center(
          child: Text(
            'Recognized Words',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).selectedRowColor,
                child: Center(
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(
      this.hasSpeech, this.isListening, this.startListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: !hasSpeech || isListening ? null : startListening,
          child: const Text('Start'),
        ),
      ],
    );
  }
}
//
// class SessionOptionsWidget extends StatelessWidget {
//   const SessionOptionsWidget(
//       this.currentLocaleId,
//       this.switchLang,
//       this.localeNames,
//       this.logEvents,
//       this.switchLogging,
//       this.pauseForController,
//       this.listenForController,
//       {Key? key})
//       : super(key: key);
//
//   final String currentLocaleId;
//   final void Function(String?) switchLang;
//   final void Function(bool?) switchLogging;
//   final TextEditingController pauseForController;
//   final TextEditingController listenForController;
//   final List<LocaleName> localeNames;
//   final bool logEvents;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Row(
//             children: [
//               const Text('Language: '),
//               DropdownButton<String>(
//                 onChanged: (selectedVal) => switchLang(selectedVal),
//                 value: currentLocaleId,
//                 items: localeNames
//                     .map(
//                       (localeName) => DropdownMenuItem(
//                     value: localeName.localeId,
//                     child: Text(localeName.name),
//                   ),
//                 )
//                     .toList(),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               const Text('pauseFor: '),
//               Container(
//                   padding: const EdgeInsets.only(left: 8),
//                   width: 80,
//                   child: TextFormField(
//                     controller: pauseForController,
//                   )),
//               Container(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: const Text('listenFor: ')),
//               Container(
//                   padding: const EdgeInsets.only(left: 8),
//                   width: 80,
//                   child: TextFormField(
//                     controller: listenForController,
//                   )),
//             ],
//           ),
//           Row(
//             children: [
//               const Text('Log events: '),
//               Checkbox(
//                 value: logEvents,
//                 onChanged: switchLogging,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
