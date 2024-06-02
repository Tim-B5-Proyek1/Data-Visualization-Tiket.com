import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AirlineLogoWidget extends StatelessWidget {
  final String logo;

  const AirlineLogoWidget({
    super.key,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
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
