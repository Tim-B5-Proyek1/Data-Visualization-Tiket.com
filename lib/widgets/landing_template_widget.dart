import 'package:data_visualization_b5/pages/landing_mobile_page.dart';
import 'package:data_visualization_b5/pages/landing_page.dart';
import 'package:data_visualization_b5/widgets/responsive_layout_widget.dart';
import 'package:flutter/material.dart';

class LandingTemplateWidget extends StatelessWidget {
  const LandingTemplateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileBody: LandingMobilePage(),
      desktopBody: LandingPage(),
    );
  }
}
