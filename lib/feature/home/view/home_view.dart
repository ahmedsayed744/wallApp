import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/feature/expandse/view/add_expense_screen.dart';
import 'package:spendwise/feature/monthly_summary/service/summary_storage_service.dart';
import 'package:spendwise/generated/l10n.dart';

import 'package:spendwise/feature/home/widget/recent_transaction_widget.dart';
import 'package:spendwise/feature/home/widget/remaining_balance_widget.dart';
import 'package:spendwise/feature/home/widget/states_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Auto-generate summaries for any completed months on startup.
    SummaryStorageService.generateIfNeeded(globalTransactions.value);

    // Re-run whenever a new transaction is added (handles mid-session rollover).
    globalTransactions.addListener(_onTransactionsChanged);
  }

  @override
  void dispose() {
    globalTransactions.removeListener(_onTransactionsChanged);
    super.dispose();
  }

  void _onTransactionsChanged() {
    SummaryStorageService.generateIfNeeded(globalTransactions.value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2C3E50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpenseView()),
          );

          if (result != null && result is TransactionModel) {
            globalTransactions.value = [...globalTransactions.value, result];
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: ValueListenableBuilder<double>(
        valueListenable: globalBudget,
        builder: (context, totalBudget, _) {
          return ValueListenableBuilder<List<TransactionModel>>(
            valueListenable: globalTransactions,
            builder: (context, transactions, child) {
              double totalSpent = transactions.fold(
                0,
                (sum, item) => sum + item.amount,
              );
              double remaining = totalBudget - totalSpent;

              return Column(
                children: [
                  /// TOP CARD
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 45,
                    ).r,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 67, 136, 146),
                          Color.fromARGB(255, 49, 67, 86),
                          Color(0xFF2C3E50),
                          Color.fromARGB(255, 39, 55, 70),
                          Color.fromARGB(255, 67, 96, 126),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(45),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).appTitle,
                          style: AppStrings.font24BlackBoldWeight.copyWith(
                            color: Colors.white,
                          ),
                        ),

                        Gap(30.h),

                        // Remaining BALANCE
                        RemainingBalanceWidget(
                          remaining: remaining,
                          totalBudget: totalBudget,
                        ),

                        Gap(20.h),

                        // STATS
                        StatesWidget(
                          totalSpent: totalSpent,
                          transactions: transactions,
                        ),
                      ],
                    ),
                  ),

                  RecentTransactionsWidget(transactions: transactions),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
