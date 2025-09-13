import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/invite_create_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class InviteCreatePage extends HookConsumerWidget {
  const InviteCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(inviteCreateViewModelProvider);
    final notifier = ref.read(inviteCreateViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('招待を作成')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('閲覧専用の招待コードを作成します。'),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: st.maybeWhen(
                            creating: () => null,
                            orElse: () => () => notifier.create(),
                          ),
                  icon: const Icon(Icons.key),
                  label: const Text('新しい招待コードを作成'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            st.when(
              idle: () => const SizedBox.shrink(),
              creating: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Text(
                message,
                style: const TextStyle(color: Colors.red),
              ),
              success: (invite) => _InviteResultView(code: invite.code),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteResultView extends StatelessWidget {
  const _InviteResultView({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final uri = 'fujii://invite/$code';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('招待コード'),
        SelectableText(
          code,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text('共有用リンク'),
        SelectableText(uri),
        const SizedBox(height: 16),
        Center(
          child: QrImageView(
            data: uri,
            version: QrVersions.auto,
            size: 200,
            gapless: true,
          ),
        ),
      ],
    );
  }
}
