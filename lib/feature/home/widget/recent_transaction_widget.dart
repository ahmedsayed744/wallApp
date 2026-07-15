import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

class RecentTransactionsWidget extends StatelessWidget {
  const RecentTransactionsWidget({super.key, required this.transactions});

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16).r,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent Transactions Header TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).recentTransactions,
                        style: AppStrings.font24BlackBoldWeight.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/CategoryView");
                        },
                        child: Text(
                          S.of(context).seeAll,
                          style: AppStrings.font18white700Weight.copyWith(
                            color: AppColors.secondaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // EMPTY OR LIST
                  transactions.isEmpty
                      ? SizedBox(
                          height: 230.h,
                          child: Center(
                            child: Text(
                              S.of(context).noTransactionsRecent,
                              style: AppStrings.font18white700Weight.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : ItemListWidget(transactions: transactions),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key, required this.transactions});

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => Gap(10.h),
      itemBuilder: (context, index) {
        final transactionx = transactions[index];

        return ListTile(
          leading: Container(
            width: 55.w,
            height: 55.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12).r,
            ),
            child: Center(
              child: transactionx.image.isNotEmpty
                  ? Image.asset(
                      transactionx.image,
                      height: 28,
                      fit: BoxFit.contain,
                    )
                  : const Icon(Icons.category, color: Colors.white),
            ),
          ),
          title: Text(
            getLocalizedCategory(context, transactionx.category),
            style: AppStrings.font18white700Weight.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            transactionx.note.isEmpty
                ? S.of(context).noNote
                : transactionx.note,
            style: AppStrings.font18white700Weight.copyWith(
              color: Colors.grey.shade600,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Text(
            NumberFormat.simpleCurrency(
              locale: Localizations.localeOf(context).toString(),
            ).format(-transactionx.amount),
            style: AppStrings.font18white700Weight.copyWith(color: Colors.red),
          ),
        );
      },
    );
  }
}
