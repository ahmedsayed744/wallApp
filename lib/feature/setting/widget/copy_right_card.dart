import 'package:flutter/material.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_strings.dart';

class CopyRightCard extends StatelessWidget {
  const CopyRightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Walltix © 2026",
      style: AppStrings.font18white700Weight.copyWith(
        color: AppColors.primaryColor,
      ),
    );
  }
}
