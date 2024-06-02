import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    super.key,
    required this.length,
    required this.currentPage,
    required this.duration,
    this.inActiveColor = Colors.black38,
  });

  final int length, currentPage, duration;
  final Color inActiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
        length,
        (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: duration),
            margin: const EdgeInsets.all(5),
            height: 10,
            width: currentPage == index ? 20 : 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: currentPage == index ? primaryColor : inActiveColor,
            ),
          );
        },
      ),
    );
  }
}
