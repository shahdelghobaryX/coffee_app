import 'package:flutter/material.dart';

import '../theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _icons = [
    Icons.home_outlined,
    Icons.shopping_cart_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];
  static const _barTop = 22.0;
  static const _anim = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final height = 84.0 + MediaQuery.of(context).padding.bottom;

    return LayoutBuilder(builder: (context, c) {
      final slot = c.maxWidth / 4;
      return SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: (currentIndex + 0.5) * slot),
                duration: _anim,
                curve: Curves.easeOut,
                builder: (_, cx, __) =>
                    CustomPaint(painter: _BarPainter(cx, _barTop)),
              ),
            ),
            for (int i = 0; i < 4; i++)
              Positioned(
                left: i * slot,
                width: slot,
                top: _barTop,
                height: 62,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(i),
                  child: Center(
                    child: i == currentIndex
                        ? const SizedBox.shrink()
                        : Icon(_icons[i], color: AppColors.dark, size: 26),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: _anim,
              curve: Curves.easeOut,
              left: currentIndex * slot + slot / 2 - 23,
              top: 7,
              width: 46,
              height: 46,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.dark,
                  shape: BoxShape.circle,
                ),
                child: Icon(_icons[currentIndex], color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      );
    });
  }
}

/// Tan bar with a smooth hump behind the active icon.
class _BarPainter extends CustomPainter {
  _BarPainter(this.cx, this.top);

  final double cx;
  final double top;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, top)
      ..lineTo(cx - 52, top)
      ..cubicTo(cx - 30, top, cx - 34, 4, cx, 4)
      ..cubicTo(cx + 34, 4, cx + 30, top, cx + 52, top)
      ..lineTo(size.width, top)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.card);
  }

  @override
  bool shouldRepaint(_BarPainter old) => old.cx != cx;
}
