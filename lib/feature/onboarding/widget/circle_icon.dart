import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/feature/onboarding/models/onboarding_model.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.item});

  final OnboardingModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: item.colors),
      child: Icon(item.icon, color: Colors.white, size: 50.w),
    );
  }
}
