import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:data_visualization_b5/widgets/page_indicator_widget.dart';
import 'package:flutter/material.dart';

class ImageHeaderWidget extends StatelessWidget {
  const ImageHeaderWidget({
    super.key,
    required this.landingProvider,
    required this.pageViewHeaderController,
  });

  final LandingProvider landingProvider;
  final PageController pageViewHeaderController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        PageView(
          controller: pageViewHeaderController,
          onPageChanged: (value) {
            landingProvider.setCurrentPageIndexHeader(value);
          },
          children: landingProvider.imageHeader,
        ),
        Positioned(
          right: 100,
          bottom: 100,
          child: PageIndicatorWidget(
            length: landingProvider.imageHeader.length,
            currentPage: landingProvider.currentPageIndexHeader,
            duration: 500,
            inActiveColor: white,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  pageViewHeaderController.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(
                  Icons.arrow_left_rounded,
                  color: white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  pageViewHeaderController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(
                  Icons.arrow_right_rounded,
                  color: white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
