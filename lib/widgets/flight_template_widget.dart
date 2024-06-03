import 'package:data_visualization_b5/pages/flight_mobile_page.dart';
import 'package:data_visualization_b5/pages/flight_page.dart';
import 'package:data_visualization_b5/widgets/responsive_layout_widget.dart';
import 'package:flutter/material.dart';

class FlightTemplateWidget extends StatelessWidget {
  const FlightTemplateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileBody: FlightMobilePage(),
      desktopBody: FlightPage(),
    );
  }
}