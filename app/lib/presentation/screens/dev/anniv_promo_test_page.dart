import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/domain/usecases/generate_anniv_promo_usecase.dart';

@RoutePage()
class AnnivPromoTestPage extends ConsumerStatefulWidget {
  const AnnivPromoTestPage({super.key});

  @override
  ConsumerState<AnnivPromoTestPage> createState() => _AnnivPromoTestPageState();
}

class _AnnivPromoTestPageState extends ConsumerState<AnnivPromoTestPage> {
  DateTime _date = DateTime.now();
  String? _result;
  String? _source;
  bool _loading = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _run() async {
    setState(() {
      _loading = true;
      _result = null;
      _source = null;
    });
    final usecase = ref.read(generateAnnivPromoUsecaseProvider);
    final res = await usecase.call(date: _date);
    res.fold(
      onSuccess: (p) {
        setState(() {
          _result = p.text;
          _source = p.source;
          _loading = false;
        });
      },
      onFailure: (e, _) {
        setState(() {
          _result = 'エラー: ${e.toString()}';
          _source = 'error';
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String fmt(DateTime d) =>
        '${d.year.toString().padLeft(4, '0')}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}'
        ' (${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')})';
    return Scaffold(
      appBar: AppBar(title: const Text('Anniv Promo Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('対象日: ${fmt(_date)}'),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : _pickDate,
                  icon: const Icon(Icons.date_range),
                  label: const Text('日付を選択'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _run,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('生成を実行'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_loading) const LinearProgressIndicator(),
            if (_result != null) ...[
              Text('source: ${_source ?? '-'}',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              SelectableText(
                _result!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
            const Spacer(),
            const Text('注意: この画面は開発/検証用です。'),
          ],
        ),
      ),
    );
  }
}
