import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';

class TotalSpendingCard extends StatelessWidget {
  const TotalSpendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: globalBudget,
      builder: (context, totalBudget, _) {
        return ValueListenableBuilder<List<TransactionModel>>(
          valueListenable: globalTransactions,
          builder: (context, transactions, child) {
            double totalSpent = transactions.fold(
              0,
              (sum, item) => sum + item.amount,
            );

            double progress = totalBudget > 0
                ? (totalSpent / totalBudget).clamp(0.0, 1.0)
                : 0.0;
            String remainingText = totalSpent > totalBudget
                ? S.of(context).overBudget
                : S.of(context).underBudget;

            return Container(
              padding: const EdgeInsets.all(20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pie_chart, color: Colors.blue, size: 20),
                      Gap(8.w),
                      Text(
                        S.of(context).totalSpendingCap,
                        style: AppStrings.font14grayRegular,
                      ),
                    ],
                  ),
                  Gap(10.h),
                  Text(
                    NumberFormat.simpleCurrency(
                      locale: Localizations.localeOf(context).toString(),
                    ).format(totalSpent),
                    style: AppStrings.font32BlueBold.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Gap(20.h),

                  /// Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                        totalSpent > totalBudget ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),

                  Gap(15.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).budgetGoal(
                          NumberFormat.simpleCurrency(
                            locale: Localizations.localeOf(context).toString(),
                            decimalDigits: 0,
                          ).format(totalBudget),
                        ),
                        style: AppStrings.font14grayRegular.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        remainingText,
                        style: AppStrings.font14grayRegular.copyWith(
                          color: totalSpent > totalBudget
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
