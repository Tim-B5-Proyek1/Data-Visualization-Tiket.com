import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class NavigationButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const NavigationButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: defaultPadding),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: secondaryTextStyle,
        ),
      ),
    );
  }
}
