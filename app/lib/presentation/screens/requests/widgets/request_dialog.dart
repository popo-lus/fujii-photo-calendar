import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/domain/usecases/submit_request_usecase.dart';

class RequestDialog extends ConsumerStatefulWidget {
  const RequestDialog({super.key, required this.ownerUid});
  final String ownerUid;

  @override
  ConsumerState<RequestDialog> createState() => _RequestDialogState();
}

class _RequestDialogState extends ConsumerState<RequestDialog> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    try {
      final submit = ref.read(submitRequestUsecaseProvider);
      await submit(ownerUid: widget.ownerUid, comment: text);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('送信に失敗しました: $e')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('リクエストを送信'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'コメント (最大500文字)',
        ),
        maxLength: 500,
        minLines: 3,
        maxLines: 6,
      ),
      actions: [
        TextButton(
          onPressed: _sending ? null : () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        FilledButton.icon(
          onPressed: _sending ? null : _onSubmit,
          icon: const Icon(Icons.send),
          label: const Text('送信'),
        ),
      ],
    );
  }
}

