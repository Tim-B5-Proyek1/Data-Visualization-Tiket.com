import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title, subtitle;
  final double paddingLeft;

  const SectionTitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.paddingLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/png/wave.png"),
          SizedBox(
            height: 50,
            width: 300,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  left: paddingLeft,
                  top: 5,
                  child: Image.asset("assets/png/yellow-circle.png"),
                ),
                Text(
                  title,
                  style: secondaryTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: secondaryTextStyle.copyWith(
              color: grey400,
            ),
          ),
        ],
      ),
    );
  }
}
