import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/invite_view_model.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';

@RoutePage()
class InviteCodePage extends HookConsumerWidget {
  const InviteCodePage({
    super.key,
    this.initialCode,
    this.initialError,
    this.autoSubmit = true,
  });

  // Deep Link からの遷移時に受け取る初期値
  final String? initialCode;
  final String? initialError;
  final bool autoSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final codeCtrl = useTextEditingController(text: initialCode ?? '');

    final state = ref.watch(inviteViewModelProvider);
    final notifier = ref.read(inviteViewModelProvider.notifier);

    ref.listen<InviteState>(inviteViewModelProvider, (prev, next) {
      if (next.maybeWhen(success: (_, _) => true, orElse: () => false)) {
        context.router.replaceAll([const MonthCalendarRoute()]);
      }
    });

    // 初期コードがあり、状態がidleなら自動送信（Deep Link UX）
    useEffect(() {
      if (autoSubmit && (initialCode != null) && (initialCode!.isNotEmpty)) {
        final st = ref.read(inviteViewModelProvider);
        if (st.maybeWhen(idle: () => true, orElse: () => false)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref
                .read(inviteViewModelProvider.notifier)
                .submit(code: initialCode!.trim());
          });
        }
      }
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(title: const Text('招待コードで閲覧')),
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
                  // Deep Link 失敗時などの明示メッセージ
                  if (initialError != null && initialError!.isNotEmpty)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.08),
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        initialError!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  TextFormField(
                    controller: codeCtrl,
                    decoration: const InputDecoration(labelText: '招待コード'),
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
                              if ((codeCtrl.text.trim()).isNotEmpty) {
                                notifier.submit(code: codeCtrl.text.trim());
                              }
                            },
                      child: state.maybeWhen(
                        loading: () => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        orElse: () => const Text('閲覧する'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  state.maybeWhen(
                    error: (msg) =>
                        Text(msg, style: const TextStyle(color: Colors.red)),
                    orElse: () => const SizedBox.shrink(),
                  ),
                  // 再取得・再試行導線
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: state.maybeWhen(
                      loading: () => null,
                      orElse: () => () {
                        final v = codeCtrl.text.trim();
                        if (v.isNotEmpty) {
                          notifier.submit(code: v);
                        }
                      },
                    ),
                    child: const Text('もう一度試す'),
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
