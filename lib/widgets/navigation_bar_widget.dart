import 'package:data_visualization_b5/widgets/navigation_button_widget.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({
    super.key,
    required this.homeKey,
    required this.flightKey,
    required this.airlineKey,
    required this.dataVisualizationKey,
    required this.aboutUsKey,
  });
  final GlobalKey homeKey,
      flightKey,
      airlineKey,
      dataVisualizationKey,
      aboutUsKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationButtonWidget(
          text: "Beranda",
          onPressed: () {
            Scrollable.ensureVisible(
              homeKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        NavigationButtonWidget(
          text: "Data Penerbangan",
          onPressed: () {
            Scrollable.ensureVisible(
              flightKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        NavigationButtonWidget(
          text: "Maskapai",
          onPressed: () {
            Scrollable.ensureVisible(
              airlineKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        NavigationButtonWidget(
          text: "Visualisasi Data",
          onPressed: () {
            Scrollable.ensureVisible(
              dataVisualizationKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        NavigationButtonWidget(
          text: "Tentang Kami",
          onPressed: () {
            Scrollable.ensureVisible(
              aboutUsKey.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
      ],
    );
  }
}
