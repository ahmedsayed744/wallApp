// Bottom Row (Back + Skip)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/routing/routs.dart';
import 'package:spendwise/core/storage/hive_manager.dart';

class BottomBackSkip extends StatelessWidget {
  const BottomBackSkip({
    super.key,
    required this.currentIndex,
    required PageController controller,
  }) : _controller = controller;

  final int currentIndex;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentIndex != 0)
            TextButton(
              onPressed: () {
                _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                S.of(context).back,
                style: AppStrings.font18white700Weight.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            )
          else
            const SizedBox(),

          TextButton(
            onPressed: () {
              // Skip onboarding
              HiveManager.setNotFirstTime();
              Navigator.pushReplacementNamed(context, Routs.rootView);
            },
            child: Text(
              S.of(context).skip,
              style: AppStrings.font18white700Weight.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
