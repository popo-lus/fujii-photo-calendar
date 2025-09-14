import 'package:flutter/material.dart';

/// 月のカレンダー（Sun開始, 罫線なし, 最小限スタイル）
class MonthCalendarGrid extends StatelessWidget {
  const MonthCalendarGrid({
    super.key,
    required this.month,
    this.holidays = const {},
    this.shrinkText = false,
    this.showHeader = true,
    this.cellAlignment = Alignment.topLeft,
    this.fixedRowHeight,
    this.fixedCellWidth,
    this.rowGap = 6.0,
    this.bodySundayHolidayTextColor,
    this.bodyWeekdayTextColor,
    this.headerSundayTextColor,
    this.headerWeekdayTextColor,
  });

  /// 表示対象の月（任意の日付。year/month を使用）
  final DateTime month;

  /// 祝日（ローカル日付, 時刻成分0）
  final Set<DateTime> holidays;

  /// 小さめ文字にする（カード内配置向け）
  final bool shrinkText;
  final bool showHeader;
  final AlignmentGeometry cellAlignment;
  final double? fixedRowHeight;
  final double? fixedCellWidth;
  final double rowGap;
  final Color? bodySundayHolidayTextColor;
  final Color? bodyWeekdayTextColor;
  final Color? headerSundayTextColor;
  final Color? headerWeekdayTextColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final year = month.year;
    final m = month.month;
    final first = DateTime(year, m, 1);
    final firstWeekdaySun0 = (first.weekday % 7); // 1(Mon)..7(Sun) -> 1..6,0
    final daysInMonth = DateTime(year, m + 1, 0).day;

    final totalSlots = firstWeekdaySun0 + daysInMonth;
    final numRows = (totalSlots / 7).ceil();
    final headerHeight = showHeader ? (shrinkText ? 18.0 : 20.0) : 0.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : (headerHeight + (numRows * 24) + ((numRows) * rowGap));
        final double rowHeight =
            fixedRowHeight ??
            ((available - headerHeight - (numRows * rowGap)) / numRows);
        final double cellWidth = fixedCellWidth ?? (constraints.maxWidth / 7);

        final List<Widget> rows = [];

        // 曜日ヘッダ（任意）
        if (showHeader) {
          const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
          rows.add(
            SizedBox(
              height: headerHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(7, (i) {
                  final isSun = i == 0;
                  final headerSunColor =
                      headerSundayTextColor ?? const Color(0xFFD94A4A);
                  final headerWeekColor =
                      headerWeekdayTextColor ?? const Color(0xFF444444);
                  final label = Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isSun ? headerSunColor : headerWeekColor,
                      fontWeight: FontWeight.w400,
                      fontSize: shrinkText ? 11 : 12,
                    ),
                  );
                  if (fixedCellWidth != null) {
                    return SizedBox(
                      width: cellWidth,
                      child: Align(alignment: Alignment.center, child: label),
                    );
                  }
                  return Expanded(
                    child: Align(alignment: Alignment.center, child: label),
                  );
                }),
              ),
            ),
          );
        }

        // 日付セル
        int day = 1;
        int rowIndex = 0;
        while (day <= daysInMonth) {
          rows.add(SizedBox(height: rowGap));
          rows.add(
            SizedBox(
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(7, (col) {
                  final isLeadingEmpty =
                      rowIndex == 0 && col < firstWeekdaySun0;
                  if (isLeadingEmpty || day > daysInMonth) {
                    return SizedBox(width: cellWidth);
                  }
                  final date = DateTime(year, m, day);
                  final isSun = col == 0;
                  final isHoliday = holidays.any(
                    (d) => _isSameLocalDay(d, date),
                  );
                  final sundayHolidayColor =
                      bodySundayHolidayTextColor ?? const Color(0xFFB33A3A);
                  final weekdayColor =
                      bodyWeekdayTextColor ?? const Color(0xFF222222);
                  final color = (isSun || isHoliday)
                      ? sundayHolidayColor
                      : weekdayColor;
                  final text = Text(
                    '$day',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontSize: shrinkText ? 12 : 13,
                      height: 1.0,
                    ),
                  );
                  day++;
                  return SizedBox(
                    width: cellWidth,
                    child: Align(alignment: cellAlignment, child: text),
                  );
                }),
              ),
            ),
          );
          rowIndex++;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: rows,
        );
      },
    );
  }

  static bool _isSameLocalDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
