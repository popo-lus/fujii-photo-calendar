import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/core/utils/perf_timer.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/invite_view_model.dart';

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
      // (T002) Auth emulator 接続
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      // (T002) 接続ログの明示出力
      AppLogger.instance.log(
        'emulator_setup',
        data: {
          'host': 'localhost',
          'firestorePort': 8080,
          'storagePort': 9199,
          'authPort': 9099,
        },
      );
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final _router = AppRouter();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  StreamSubscription<Uri?>? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _handleInitialLink();
    _sub = uriLinkStream.listen(
      (Uri? uri) {
        if (uri == null) return;
        _handleInviteUri(uri);
      },
      onError: (Object e) {
        debugPrint('deeplink error: $e');
      },
    );
  }

  Future<void> _handleInitialLink() async {
    try {
      final initial = await getInitialUri();
      if (initial != null) {
        _handleInviteUri(initial);
      }
    } catch (e) {
      debugPrint('initial link error: $e');
    }
  }

  void _handleInviteUri(Uri uri) {
    // 期待する形式: fujii://invite?code=XXXX または https://.../invite?code=XXXX
    final code = uri.queryParameters['code'];
    if (code == null || code.isEmpty) return;
    // 既存の招待コード入力機能を使う
    final container = ProviderScope.containerOf(context, listen: false);
    final vm = container.read(inviteViewModelProvider.notifier);
    vm.submit(code: code).then((_) {
      // 成功時は InviteCodePage のリスナでカレンダーへ遷移済み
      // 失敗時はエラーステートが表示される画面が必要だが、今回は無視
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Fujii Photo Calendar',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    routerConfig: MyApp._router.config(),
  );
}
