import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'month_calendar_grid.dart';
import 'month_label.dart';
import 'dart:async';
import 'dart:ui' show ImageFilter;

/// 添付イメージ風の卓上カード: 左に正方形写真、右に月間カレンダー
/// レイアウト: Row[ Column[Image, MonthLabel], 24px, MonthCalendarGrid ]
class PhotoCalendarCard extends StatelessWidget {
  const PhotoCalendarCard({
    super.key,
    required this.month,
    this.imageUrl,
    this.imageUrls,
    this.holidays = const {},
    this.onTapImageWhenEmpty,
    this.onTapImageWhenExists,
  });

  final DateTime month;
  final String? imageUrl;
  final List<String>? imageUrls;
  final Set<DateTime> holidays;
  final VoidCallback? onTapImageWhenEmpty;
  final VoidCallback? onTapImageWhenExists;

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFFAF8F3); // オフホワイト（画像が無い場合のフォールバック）
    final urls = (imageUrls != null && imageUrls!.isNotEmpty)
        ? imageUrls!
        : (imageUrl != null && imageUrl!.isNotEmpty)
        ? <String>[imageUrl!]
        : const <String>[];
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: _FullScreenImageBackground(
                urls: urls,
                onTapEmpty: onTapImageWhenEmpty,
                onTapExists: onTapImageWhenExists,
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: _GlassyCalendarOverlay(month: month, holidays: holidays),
            ),
          ],
        ),
      ),
    );
  }
}

class _FullScreenImageBackground extends StatefulWidget {
  const _FullScreenImageBackground({
    required this.urls,
    this.onTapEmpty,
    this.onTapExists,
  });
  final List<String> urls;
  final VoidCallback? onTapEmpty;
  final VoidCallback? onTapExists;

  @override
  State<_FullScreenImageBackground> createState() =>
      _FullScreenImageBackgroundState();
}

class _FullScreenImageBackgroundState
    extends State<_FullScreenImageBackground> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _setupTimer();
  }

  @override
  void didUpdateWidget(covariant _FullScreenImageBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.urls.length != widget.urls.length) {
      _index = 0;
      _setupTimer();
    }
  }

  void _setupTimer() {
    _timer?.cancel();
    if (widget.urls.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (!mounted) return;
      setState(() {
        _index = (_index + 1) % widget.urls.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.urls.isNotEmpty;
    if (!hasImage) {
      return GestureDetector(
        onTap: () => widget.onTapEmpty?.call(),
        child: Container(color: const Color(0xFFEDEDED)),
      );
    }
    if (widget.urls.length > 1) {
      final width = MediaQuery.of(context).size.width;
      final base = width < 480
          ? 2
          : width < 800
          ? 3
          : 4;
      final cross = widget.urls.length < base ? widget.urls.length : base;

      return Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: CachedNetworkImage(
              imageUrl: widget.urls.first,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
          ),
          MasonryGridView.count(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: cross,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemCount: widget.urls.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => widget.onTapExists?.call(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.urls[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: GestureDetector(
        key: ValueKey(widget.urls[_index]),
        onTap: () => widget.onTapExists?.call(),
        child: CachedNetworkImage(
          imageUrl: widget.urls[_index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _GlassyCalendarOverlay extends StatelessWidget {
  const _GlassyCalendarOverlay({required this.month, required this.holidays});

  final DateTime month;
  final Set<DateTime> holidays;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.40), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MonthCalendarGrid(
                month: DateTime(month.year, month.month, 1),
                holidays: holidays,
                shrinkText: true,
                showHeader: true,
                cellAlignment: Alignment.center,
                fixedRowHeight: 16,
                fixedCellWidth: 20,
                rowGap: 2,
                headerSundayTextColor: const Color(0xFF8E2A2A),
                headerWeekdayTextColor: const Color(0xFF222222),
                bodySundayHolidayTextColor: const Color(0xFF8E2A2A),
                bodyWeekdayTextColor: const Color(0xFF151515),
              ),
              const SizedBox(width: 12),
              MonthLabel(month: month),
            ],
          ),
        ),
      ),
    );
  }
}
