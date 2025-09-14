import 'package:flutter/material.dart';

/// 左下の月ラベル: 大きな数字 + 小さな年・英語月名
class MonthLabel extends StatelessWidget {
  const MonthLabel({super.key, required this.month});
  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final year = month.year;
    final m = month.month;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$m',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 60, // 以前の約2倍
            fontWeight: FontWeight.w500,
            height: 1.0,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$year',
          textAlign: TextAlign.left,
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 20,
            height: 1.25,
            color: const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
