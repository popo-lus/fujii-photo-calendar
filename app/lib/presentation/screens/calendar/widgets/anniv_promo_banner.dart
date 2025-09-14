import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/providers/anniv_promo_providers.dart';

class AnnivPromoBanner extends ConsumerWidget {
  const AnnivPromoBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncText = ref.watch(todayAnnivPromoTextProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(Icons.celebration, size: 16, color: Color(0xFF8E2A2A)),
            const SizedBox(width: 6),
            Flexible(
              child: asyncText.when(
                loading: () => Text(
                  '記念日を読み込み中…',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF222222),
                    fontSize: 12,
                    height: 1.1,
                  ),
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                error: (_, __) => Text(
                  '今日はちょっと特別。小さなご褒美をどうぞ。',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF222222),
                    fontSize: 12,
                    height: 1.1,
                  ),
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                data: (text) => Text(
                  text,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF222222),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
