import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/category/widget/category_transaction_card.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C3E50),
        surfaceTintColor: Color(0xFF2C3E50),
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).categories,
          style: AppStrings.font24BlackBoldWeight.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          /// List
          Expanded(
            child: ValueListenableBuilder<List<TransactionModel>>(
              valueListenable: globalTransactions,
              builder: (context, transactions, child) {
                if (transactions.isEmpty) return const SizedBox();

                final grouped = <String, List<TransactionModel>>{};
                for (var t in transactions) {
                  grouped.putIfAbsent(t.category, () => []).add(t);
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: grouped.keys.length,
                  separatorBuilder: (_, _) => Gap(15.h),
                  itemBuilder: (context, index) {
                    final category = grouped.keys.elementAt(index);
                    final txs = grouped[category]!;
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 22,
                        left: 22,
                      ).r,
                      child: CategoryTransactionCard(
                        categoryName: category,
                        transactions: txs,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
