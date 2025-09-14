import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/register_view_model.dart';
import 'package:fujii_photo_calendar/core/utils/validators/auth_validators.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'package:fujii_photo_calendar/presentation/screens/auth/widgets/pinterest_background.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameCtrl = useTextEditingController();
    final emailCtrl = useTextEditingController();
    final pwCtrl = useTextEditingController();
    final obscure = useState(true);

    final state = ref.watch(registerViewModelProvider);
    final notifier = ref.read(registerViewModelProvider.notifier);

    ref.listen<RegisterState>(registerViewModelProvider, (prev, next) {
      if (next.maybeWhen(success: (_) => true, orElse: () => false)) {
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
                          Text(
                            'アカウントを作成',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
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
                            controller: nameCtrl,
                            decoration: const InputDecoration(labelText: '表示名'),
                            validator: AuthValidators.validateDisplayName,
                            enabled: !state.maybeWhen(
                              loading: () => true,
                              orElse: () => false,
                            ),
                          ),
                          const SizedBox(height: 16),
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
                                        notifier.submit(
                                          displayName: nameCtrl.text.trim(),
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
                                orElse: () => const Text('登録'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          state.maybeWhen(
                            error: (msg) => Text(
                              msg,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            orElse: () => const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () =>
                                context.router.replace(const LoginRoute()),
                            child: const Text('ログインはこちら'),
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
