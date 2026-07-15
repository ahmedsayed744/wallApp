import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/generated/l10n.dart';

class RemainingBalanceWidget extends StatelessWidget {
  const RemainingBalanceWidget({
    super.key,
    required this.remaining,
    required this.totalBudget,
  });

  final double remaining;
  final double totalBudget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(16).r,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).remainingBalance,
            style: AppStrings.font18white700Weight.copyWith(fontSize: 16),
          ),
          Gap(10.h),
          Row(
            children: [
              Text(
                NumberFormat.simpleCurrency(
                  locale: Localizations.localeOf(context).toString(),
                ).format(remaining),
                style: AppStrings.font18white700Weight.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // User budget
              Text(
                " / ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString(), decimalDigits: 0).format(totalBudget)}",
                style: AppStrings.font18white700Weight.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
