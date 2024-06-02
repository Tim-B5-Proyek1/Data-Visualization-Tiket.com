import 'package:data_visualization_b5/common/constant.dart';
import 'package:flutter/material.dart';

class TeamMemberCardWidget extends StatelessWidget {
  final String member;
  const TeamMemberCardWidget({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        child: Image.asset(
          "assets/png/$member.png",
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
