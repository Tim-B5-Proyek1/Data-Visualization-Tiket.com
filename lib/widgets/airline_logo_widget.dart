import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AirlineLogoWidget extends StatelessWidget {
  final String logo;
  final double height, width;

  const AirlineLogoWidget({
    super.key,
    required this.logo,
    this.height = 150,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: white,
      ),
      child: SvgPicture.asset(
        "assets/svg/$logo.svg",
        color: black,
        fit: BoxFit.contain,
      ),
    );
  }
}
