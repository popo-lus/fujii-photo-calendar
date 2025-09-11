import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/login_view_model.dart';
import 'package:fujii_photo_calendar/core/utils/validators/auth_validators.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';

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
      if (next is LoginSuccess) {
        context.router.replaceAll([const MonthCalendarRoute()]);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    validator: AuthValidators.validateEmail,
                    enabled: state is! LoginLoading,
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
                    enabled: state is! LoginLoading,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                notifier.login(
                                  email: emailCtrl.text.trim(),
                                  password: pwCtrl.text,
                                );
                              }
                            },
                      child: switch (state) {
                        LoginLoading() => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        _ => const Text('ログイン'),
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (state is LoginError)
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
