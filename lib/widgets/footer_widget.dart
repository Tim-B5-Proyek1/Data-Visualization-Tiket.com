import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "© 2024 ",
            style: primaryTextStyle,
          ),
          Text(
            "B5 Proyek 1. ",
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
          Text(
            "All Rights Reserved",
            style: primaryTextStyle,
          ),
        ],
      ),
    );
  }
}
