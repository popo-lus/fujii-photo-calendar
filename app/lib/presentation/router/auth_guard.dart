// (T010) AuthGuard: 未ログインなら LoginRoute へリダイレクト
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'app_router.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;
  final FirebaseAuth _auth;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final user = _auth.currentUser;
    if (user != null) {
      // (T017) セッション再利用ログ
      AppLogger.instance.log('auth_session_reuse', data: {'uid': user.uid});
      resolver.next(true);
    } else {
      resolver.redirectUntil(const LoginRoute());
    }
  }
}
