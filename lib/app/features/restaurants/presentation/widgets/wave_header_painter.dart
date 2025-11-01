import 'package:flutter/material.dart';

/// Custom painter for the wave pattern with holes in the header.
class WaveHeaderPainter extends CustomPainter {
  const WaveHeaderPainter({
    this.color = const Color(0xFFFF5722),
  });
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height - 40)

      // 5 flatter alternating curves (starts downward)
      ..quadraticBezierTo(
        size.width * 1 / 10,
        size.height - 25, // Up
        size.width * 2 / 10,
        size.height - 40, // Down
      )
      ..quadraticBezierTo(
        size.width * 3 / 10,
        size.height - 55, // Downward dip (hole)
        size.width * 4 / 10,
        size.height - 40, // Up
      )
      ..quadraticBezierTo(
        size.width * 5 / 10,
        size.height - 25, // Up peak
        size.width * 6 / 10,
        size.height - 40, // Down
      )
      ..quadraticBezierTo(
        size.width * 7 / 10,
        size.height - 50, // Down
        size.width * 8 / 10,
        size.height - 40, // Up
      )
      ..quadraticBezierTo(
        size.width * 9 / 10,
        size.height - 25, // Up
        size.width,
        size.height - 40, // End flat
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
