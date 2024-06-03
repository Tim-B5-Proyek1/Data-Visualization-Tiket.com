import 'package:data_visualization_b5/common/dimension.dart';
import 'package:flutter/material.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget mobileBody,desktopBody;

  const ResponsiveLayoutWidget({
    super.key,
    required this.mobileBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < tabletWidth) {
        return mobileBody;
      }  else {
        return desktopBody;
      }
    });
  }
}