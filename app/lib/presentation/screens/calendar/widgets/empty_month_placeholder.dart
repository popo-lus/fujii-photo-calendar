// (T023) 空月プレースホルダー
import 'package:flutter/material.dart';

class EmptyMonthPlaceholder extends StatelessWidget {
  const EmptyMonthPlaceholder({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('No photos yet'));
}
