import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class ImageHeaderItemWidget extends StatelessWidget {
  const ImageHeaderItemWidget({
    super.key,
    required this.pathImage,
  });

  final String pathImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 400,
          width: double.maxFinite,
          child: Image.asset(
            pathImage,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        Container(
          height: 400,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        Positioned(
          left: 100,
          child: Text(
            "Visualisasi Data Tiket.com\noleh B5",
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 50,
            ),
          ),
        ),
      ],
    );
  }
}
