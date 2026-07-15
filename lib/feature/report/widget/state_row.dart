import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';
import 'package:intl/intl.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TransactionModel>>(
      valueListenable: globalTransactions,
      builder: (context, transactions, _) {
        String topCategory = "-";
        
        if (transactions.isNotEmpty) {
          Map<String, double> categorySums = {};
          for (var t in transactions) {
            categorySums[t.category] = (categorySums[t.category] ?? 0) + t.amount;
          }
          
          if (categorySums.isNotEmpty) {
            var topEntry = categorySums.entries.reduce(
                (a, b) => a.value > b.value ? a : b);
            if (topEntry.value > 0) {
              topCategory = topEntry.key;
            }
          }
        }

        // Daily Avg Calculation
        double totalSpent = transactions.fold(0, (sum, item) => sum + item.amount);
        final currencyFormat = NumberFormat.simpleCurrency(
          locale: Localizations.localeOf(context).toString(),
        );
        String dailyAvg = transactions.isEmpty
            ? currencyFormat.format(0)
            : currencyFormat.format(totalSpent / 30);

        String localizedTopCategory = topCategory == "-"
            ? "-"
            : getLocalizedCategory(context, topCategory);

        return Row(
          children: [
            Expanded(
              child: StatItem(
                icon: Icons.show_chart,
                title: S.of(context).dailyAvg,
                value: dailyAvg,
              ),
            ),
            Gap(15.w),
            Expanded(
              child: StatItem(
                icon: Icons.account_balance_wallet,
                title: S.of(context).topCategory,
                value: localizedTopCategory,
              ),
            ),
          ],
        );
      },
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 0.6,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue),
          Gap(10.h),
          Text(
            title,
            style: AppStrings.font14grayRegular.copyWith(color: Colors.grey),
          ),
          Gap(5.h),
          Text(
            value,
            style: AppStrings.font18white700Weight.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
