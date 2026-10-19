import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:streetbite/app.dart';
import 'package:streetbite/firebase_options.dart';
import 'package:streetbite/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safety net: an error that escapes the repositories is logged here
  // instead of crashing the app.
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Unhandled error: $error\n$stack');
    return true;
  };

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  runApp(const StreetBiteApp());
}
