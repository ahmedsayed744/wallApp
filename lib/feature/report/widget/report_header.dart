import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/generated/l10n.dart';

class ReportHeader extends StatelessWidget {
  const ReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).monthlySpendingReport,
          style: AppStrings.font24BlackBoldWeight.copyWith(fontSize: 32.sp),
        ),
        Gap(5.h),
      ],
    );
  }
}
