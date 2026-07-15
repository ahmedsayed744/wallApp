import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/generated/l10n.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4CA1AF),
            Color(0xFF2C3E50),
            Color(0xFF2C3E50),
            Color(0xFF2C3E50),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Center(
        child: Text(
          S.of(context).appTitle,
          style: AppStrings.font18white700Weight.copyWith(fontSize: 20.sp),
        ),
      ),
    );
  }
}
