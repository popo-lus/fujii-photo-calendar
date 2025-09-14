import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/auth/invite_create_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:fujii_photo_calendar/presentation/widgets/glass_containers.dart';

@RoutePage()
class InviteCreatePage extends HookConsumerWidget {
  const InviteCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final st = ref.watch(inviteCreateViewModelProvider);
    final notifier = ref.read(inviteCreateViewModelProvider.notifier);

    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('招待を作成'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ほんのりグラデの背景
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primaryContainer.withOpacity(0.35),
                  colorScheme.surface.withOpacity(0.2),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlassContainer(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '閲覧専用の招待コードを作成します。',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: st.maybeWhen(
                            creating: () => null,
                            orElse: () =>
                                () => notifier.create(),
                          ),
                          icon: const Icon(Icons.key),
                          label: const Text('新しい招待コードを作成'),
                        ),
                        const SizedBox(height: 24),
                        st.when(
                          idle: () => const SizedBox.shrink(),
                          creating: () => const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          error: (message) => Text(
                            message,
                            style: TextStyle(color: colorScheme.error),
                          ),
                          success: (invite) =>
                              _InviteResultView(code: invite.code),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('招待コード'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SelectableText(
                      code,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'コードをコピー',
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: code));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('招待コードをコピーしました')),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('共有用リンク'),
              SelectableText(uri),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // QR はガラス効果の外に出して合成問題を回避
        QrImageView(
          data: uri,
          version: QrVersions.auto,
          size: 220,
          gapless: true,
          backgroundColor: Colors.transparent,
          eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
