import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/core/utils/perf_timer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initTimer = PerfTimer('firebase_init');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final initMs = initTimer.stop();

  const useEmulators = bool.fromEnvironment(
    'USE_FIREBASE_EMULATORS',
    defaultValue: true,
  );
  if (useEmulators) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      debugPrint('Emulator setup skipped/already connected: $e');
    }
  }

  AppLogger.instance.logStartup(
    useEmulators: useEmulators,
    firebaseInitMs: initMs,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _router = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Fujii Photo Calendar',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    routerConfig: _router.config(),
  );
}
