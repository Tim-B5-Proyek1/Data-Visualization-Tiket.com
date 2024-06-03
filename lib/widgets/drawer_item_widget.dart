import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String? text;
  final Function()? onTap;

  const DrawerItemWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        child: ListTile(
          onTap: onTap,
          title: Text(
            text.toString(),
            style: secondaryTextStyle,
          ),
        ),
      ),
    );
  }
}