import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/utils/Colors.dart';

class DashedLinePainter extends CustomPainter {
  final double dotSize;
  final double dotSpace;
  final Color color;

  DashedLinePainter({
    this.dotSize = 2,
    this.dotSpace = 4,
    this.color = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = dotSize;

    while (startX < size.width) {
      canvas.drawCircle(Offset(startX, size.height / 2), dotSize / 2, paint);
      startX += dotSize + dotSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLine extends StatelessWidget {
  final double dotSize;
  final double dotSpace;
  final Color color;

  DashedLine({
    this.dotSize = 2,
    this.dotSpace = 4,
    this.color = const Color.fromRGBO(122, 114, 137, 1),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, dotSize),
          painter: DashedLinePainter(
            dotSize: dotSize,
            dotSpace: dotSpace,
            color: color,
          ),
        );
      },
    );
  }
}

Widget adminPageTitle(String text) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: AppColors.White,
      child: Center(
        child: Text(
          "${text}",
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 7.sp,
              fontWeight: FontWeight.w600),
        ),
      ));
}

///垂直虛線
///
class DashedLine_vertical extends StatelessWidget {
  final double dotSize;
  final double dotSpace;
  final Color color;

  DashedLine_vertical({
    this.dotSize = 2,
    this.dotSpace = 4,
    this.color = const Color.fromRGBO(122, 114, 137, 1),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(dotSize, constraints.maxHeight),
          painter: DashedLinePainter_vertical(
            dotSize: dotSize,
            dotSpace: dotSpace,
            color: color,
            isVertical: true,
          ),
        );
      },
    );
  }
}

class DashedLinePainter_vertical extends CustomPainter {
  final double dotSize;
  final double dotSpace;
  final Color color;
  final bool isVertical;

  DashedLinePainter_vertical({
    required this.dotSize,
    required this.dotSpace,
    required this.color,
    this.isVertical = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dotSize;

    double start = 0;
    while (start < (isVertical ? size.height : size.width)) {
      if (isVertical) {
        canvas.drawLine(Offset(0, start), Offset(0, start + dotSize), paint);
      } else {
        canvas.drawLine(Offset(start, 0), Offset(start + dotSize, 0), paint);
      }
      start += dotSize + dotSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter_vertical oldDelegate) {
    return oldDelegate.dotSize != dotSize ||
        oldDelegate.dotSpace != dotSpace ||
        oldDelegate.color != color ||
        oldDelegate.isVertical != isVertical;
  }
}
