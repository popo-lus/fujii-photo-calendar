// 月移動ナビゲーションバー
import 'package:flutter/material.dart';

class MonthNavBar extends StatelessWidget {
  const MonthNavBar({super.key, required this.onPrev, required this.onNext});
  final VoidCallback onPrev;
  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) => BottomAppBar(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: onPrev, icon: const Icon(Icons.chevron_left)),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    ),
  );
}
