import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qswait/utils/Colors.dart';

class CustomNumberCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int number;

  const CustomNumberCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(8.0),
        // border: Border.all(color: Colors.grey),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4.0,
        //     spreadRadius: 2.0,
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.grey),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            number.toString(),
            style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('Custom Number Card')),
//       body: Center(
//         child: CustomNumberCard(
//           icon: Icons.menu_book,
//           title: '現在叫的號碼為',
//           number: 24,
//         ),
//       ),
//     ),
//   ));
// //
class CustomNumberCard_v2 extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> numbers;

  const CustomNumberCard_v2({
    Key? key,
    required this.icon,
    required this.title,
    required this.numbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackgroundColor,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            // color: AppColors.primaryBackgroundColor,
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: AppColors.primaryBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              // borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              // border: Border.all(color: Colors.grey),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.1),
              //     blurRadius: 4.0,
              //     spreadRadius: 2.0,
              //   ),
              // ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, color: AppColors.CommonText),
                    SizedBox(width: 8.0),
                    Text(
                      title,
                      style: TextStyle(
                          color: AppColors.CommonText, fontSize: 20.0),
                    ),
                  ],
                ),
                // SizedBox(height: 24.0),
                SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: numbers
                      .map((number) => Container(
                            // color: AppColors.White,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: AppColors.White,
                                // border: Border.all(color: AppColors.),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4.0,
                                    spreadRadius: 2.0,
                                  ),
                                ]),
                            child: Text(number.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: AppColors.CommonText)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: -10,
          //   child: ClipRect(
          //     child: Container(
          //       color: Colors.white,
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 8.0,
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Icon(icon, color: Colors.grey),
          //           SizedBox(width: 8.0),
          //           Text(
          //             title,
          //             style: TextStyle(color: Colors.grey, fontSize: 16.0),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

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
