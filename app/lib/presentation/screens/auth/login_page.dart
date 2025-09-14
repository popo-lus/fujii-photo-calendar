import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/login_view_model.dart';
import 'package:fujii_photo_calendar/core/utils/validators/auth_validators.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'package:fujii_photo_calendar/domain/entities/auth_result.dart';
import 'package:fujii_photo_calendar/presentation/screens/auth/widgets/pinterest_background.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailCtrl = useTextEditingController();
    final pwCtrl = useTextEditingController();
    final obscure = useState(true);

    final state = ref.watch(loginViewModelProvider);
    final notifier = ref.read(loginViewModelProvider.notifier);

    ref.listen<LoginState>(loginViewModelProvider, (prev, next) {
      if (next.maybeWhen(
        success: (AuthResult _) => true,
        orElse: () => false,
      )) {
        context.router.replaceAll([const MonthCalendarRoute()]);
      }
    });

    return Scaffold(
      body: PinterestBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          // ブランドロゴ（存在すれば表示）
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 8),
                            child: Image.asset(
                              'assets/brand/logo.png',
                              height: 40,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Text(
                                  'Fujii Photo Calendar',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '思い出をカレンダーに',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: emailCtrl,
                            decoration: const InputDecoration(
                              labelText: 'メールアドレス',
                            ),
                            validator: AuthValidators.validateEmail,
                            enabled: !state.maybeWhen(
                              loading: () => true,
                              orElse: () => false,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: pwCtrl,
                            decoration: InputDecoration(
                              labelText: 'パスワード',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () => obscure.value = !obscure.value,
                              ),
                            ),
                            obscureText: obscure.value,
                            validator: AuthValidators.validatePassword,
                            enabled: !state.maybeWhen(
                              loading: () => true,
                              orElse: () => false,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  state.maybeWhen(
                                    loading: () => true,
                                    orElse: () => false,
                                  )
                                  ? null
                                  : () {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        notifier.login(
                                          email: emailCtrl.text.trim(),
                                          password: pwCtrl.text,
                                        );
                                      }
                                    },
                              child: state.maybeWhen(
                                loading: () => const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                orElse: () => const Text('ログイン'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          state.maybeWhen(
                            error: (String msg) => Text(
                              msg,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            orElse: () => const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => context.router.push(
                                    const RegisterRoute(),
                                  ),
                                  child: const Text('新規登録'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      context.router.push(InviteCodeRoute()),
                                  child: const Text('招待コードで閲覧'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
