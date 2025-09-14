import 'dart:ui';

import 'package:flutter/material.dart';

/// ガラス風の丸ボタン。
class GlassCircleButton extends StatelessWidget {
  const GlassCircleButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 48,
    this.iconColor,
    this.blurSigma = 12,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final Color? iconColor;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Widget button = ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: Center(
                child: Icon(
                  icon,
                  size: 22,
                  color: (onPressed == null)
                      ? (iconColor ?? colorScheme.primary).withOpacity(0.35)
                      : (iconColor ?? colorScheme.primary),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (tooltip == null || tooltip!.isEmpty) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}

/// ガラス風の丸いコンテナ（タップ検知なし）。
class GlassCircle extends StatelessWidget {
  const GlassCircle({
    super.key,
    required this.size,
    this.blurSigma = 12,
    required this.child,
  });

  final double size;
  final double blurSigma;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.15),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// ガラス風の丸ボタン + ポップアップメニュー
class GlassCirclePopupMenuButton<T> extends StatelessWidget {
  const GlassCirclePopupMenuButton({
    super.key,
    required this.itemBuilder,
    this.onSelected,
    this.icon = Icons.more_vert,
    this.size = 48,
    this.iconColor,
    this.tooltip,
  });

  final PopupMenuItemBuilder<T> itemBuilder;
  final void Function(T value)? onSelected;
  final IconData icon;
  final double size;
  final Color? iconColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Widget iconWidget = Center(
      child: Icon(icon, size: 22, color: iconColor ?? colorScheme.primary),
    );

    final Widget child = GlassCircle(size: size, child: iconWidget);
    return Tooltip(
      message: tooltip ?? '',
      child: PopupMenuButton<T>(
        itemBuilder: itemBuilder,
        onSelected: onSelected,
        padding: EdgeInsets.zero,
        color: Colors.white.withOpacity(0.85),
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        offset: const Offset(0, 8),
        child: child,
      ),
    );
  }
}
