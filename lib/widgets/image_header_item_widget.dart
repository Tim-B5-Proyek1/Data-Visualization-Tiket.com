import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/widgets/responsive_layout_widget.dart';
import 'package:flutter/material.dart';

class ImageHeaderItemWidget extends StatelessWidget {
  const ImageHeaderItemWidget({
    super.key,
    required this.pathImage,
    required this.caption,
  });

  final String pathImage, caption;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileBody: Stack(
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
            left: 80,
            child: Text(
              caption,
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
      desktopBody: Stack(
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
              caption,
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
