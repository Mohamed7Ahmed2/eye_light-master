import 'dart:math';

import 'package:eye_light/data/firebase/auth_helper.dart';
import 'package:eye_light/modle/user.dart';
import 'package:eye_light/navigator/router_class.dart';
import 'package:eye_light/resources/color_manager.dart';
import 'package:eye_light/ui/screen/auth_screens/create_acount_blind.dart';
import 'package:eye_light/ui/screen/camera_or_inquiry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
    initSpeechState();
  }
  bool isCheckLogin = false;
  cahngeIscheckLogin() {
    isCheckLogin = !isCheckLogin;
    notifyListeners();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserApp? loggedUser;

  register() async {
    String email =
        firstNameController.text.trim() + lastNameController.text.trim();
    email.replaceAll(' ', '');
    emailController.text = '$email@gmail.com';

    UserApp userApp = UserApp(
        name: firstNameController.text + lastNameController.text,
        email: emailController.text,
        password: passwordController.text);
    try {
      UserCredential? x = await AuthHelper.authHelper
          .createNewAccount(userApp.email!.trim(), userApp.password!.trim());
      userApp.id = x?.user!.uid;
      final snackBar = SnackBar(
        content: const Text('تمت التسجيل بنجاح'),
        backgroundColor: ColorManager.indecatorBorder,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      );
      RouterClass.routerClass.rootScaffoldMessengerKey.currentState
          ?.showSnackBar(snackBar);
      RouterClass.routerClass.pushWidgetRemovePrev(const CameraOrInquiry());
    } on Exception {
      const snackBar = SnackBar(
        content: Text('خطأ في التسجيل '),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      );
      RouterClass.routerClass.rootScaffoldMessengerKey.currentState
          ?.showSnackBar(snackBar);
    }
  }

  login() async {
    try {
      await AuthHelper.authHelper
          .signIn(emailController.text.trim(), passwordController.text.trim());
      if (AuthHelper.authHelper.success) {
        RouterClass.routerClass.pushWidgetReplacement(const CameraOrInquiry());
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  forgetPassword(String email) async {
    AuthHelper.authHelper.forgetPassword(email);
  }

  // speak to text
  bool hasSpeech = false;
  bool logEvents = false;

  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  // String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String currentLocaleId = '';
  List<LocaleName> localeNames = [];
  final SpeechToText speech = SpeechToText();

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        currentLocaleId = systemLocale?.localeId ?? '';
      }
      // if (!_hasSpeech != null) return;

      hasSpeech = hasSpeech;
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      hasSpeech = false;
    }
  }

  void startListeningFirstName() {
    firstNameController.text = '';
    lastError = '';
    final pauseFor = int.tryParse('3');
    final listenFor = int.tryParse('30');

    speech.listen(
        onResult: resultListenerFirstName,
        listenFor: Duration(seconds: listenFor ?? 30),
        pauseFor: Duration(seconds: pauseFor ?? 3),
        partialResults: true,
        localeId: currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void resultListenerFirstName(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    firstNameController.text = result.recognizedWords;
    notifyListeners();
  }

  void startListeningLastName() {
    lastNameController.text = '';
    lastError = '';
    final pauseFor = int.tryParse('3');
    final listenFor = int.tryParse('30');

    speech.listen(
        onResult: resultListenerLastName,
        listenFor: Duration(seconds: listenFor ?? 30),
        pauseFor: Duration(seconds: pauseFor ?? 3),
        partialResults: true,
        localeId: currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void resultListenerLastName(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    lastNameController.text = result.recognizedWords;
    notifyListeners();
  }

  void startListeningPassword() {
    passwordController.text = '';
    lastError = '';
    final pauseFor = int.tryParse('3');
    final listenFor = int.tryParse('30');

    speech.listen(
        onResult: resultListenerPassword,
        listenFor: Duration(seconds: listenFor ?? 30),
        pauseFor: Duration(seconds: pauseFor ?? 3),
        partialResults: true,
        localeId: currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void resultListenerPassword(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    passwordController.text = result.recognizedWords;
    passwordController.text = passwordController.text.replaceAll(' ', '');
    notifyListeners();
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');

    this.level = level;
    notifyListeners();
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    lastError = '${error.errorMsg} - ${error.permanent}';
    notifyListeners();
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');

    lastStatus = status;
    notifyListeners();
  }

  // void _switchLang(selectedVal) {
  //
  //     currentLocaleId = selectedVal;
  //     notifyListeners();
  // }

  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  // void _switchLogging(bool? val) {
  //
  //     logEvents = val ?? false;
  //     notifyListeners();
  // }

  //text to speak
  final String defaultLanguage = 'en-US';
  TextToSpeech tts = TextToSpeech();
  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    // voice = await getVoiceByLang(languageCode!);
    notifyListeners();
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  void speak(String text2) {
    tts.setVolume(1);
    tts.setRate(0.9);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(0.9);
    tts.speak(text2);
  }

//  Auth Finger
  final LocalAuthentication auth = LocalAuthentication();
  // bool _isAuthenticating = false;
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      // _isAuthenticating = true;
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      if (authenticated == true) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          RouterClass.routerClass.pushWidget(CreateAccountBlindScreen());
        } else {
          RouterClass.routerClass.pushWidgetRemovePrev(const CameraOrInquiry());
        }
      }
    } on PlatformException catch (e) {
      print(e);
      // _isAuthenticating = false;
      return;
    }
  }

  Future<void> authenticateREgister() async {
    bool authenticated = false;
    try {
      // _isAuthenticating = true;
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      if (authenticated == true) {
        final snackBar = SnackBar(
          content: const Text('تمت إضافة البصمة بنجاج'),
          backgroundColor: ColorManager.indecatorBorder,
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        );
        RouterClass.routerClass.rootScaffoldMessengerKey.currentState
            ?.showSnackBar(snackBar);
      }
    } on PlatformException catch (e) {
      print(e);
      // _isAuthenticating = false;
      return;
    }
  }
}
