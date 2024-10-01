import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qswait/utils/Colors.dart';

class IconBackground extends StatelessWidget {
  final String iconPath;
  final Color color;
  final double size;

  const IconBackground({
    Key? key,
    required this.iconPath,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
          ),
          child: SvgPicture.asset(
            iconPath,
            width: size,
            height: size,
            color: AppColors.CommonText,
          ),
        ),
      ),
    );
  }
}
