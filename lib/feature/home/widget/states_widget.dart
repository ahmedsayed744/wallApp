import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';

class StatesWidget extends StatelessWidget {
  const StatesWidget({
    super.key,
    required this.totalSpent,
    required this.transactions,
  });

  final double totalSpent;
  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCardWidget(
            title: S.of(context).totalSpending,
            value: NumberFormat.simpleCurrency(
              locale: Localizations.localeOf(context).toString(),
            ).format(totalSpent),
            icon: Icons.attach_money_outlined,
          ),
        ),
        Gap(15.w),
        Expanded(
          child: StatCardWidget(
            title: S.of(context).transactions,
            value: NumberFormat.decimalPattern(
              Localizations.localeOf(context).toString(),
            ).format(transactions.length),
            icon: Icons.wallet_outlined,
          ),
        ),
      ],
    );
  }
}

class StatCardWidget extends StatelessWidget {
  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              Text(
                title,
                style: AppStrings.font18white700Weight.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(10.h),
          Text(value, style: AppStrings.font18white700Weight),
        ],
      ),
    );
  }
}
