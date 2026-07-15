import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

class CategoryTransactionCard extends StatefulWidget {
  final String categoryName;
  final List<TransactionModel> transactions;

  const CategoryTransactionCard({
    super.key,
    required this.categoryName,
    required this.transactions,
  });

  @override
  State<CategoryTransactionCard> createState() =>
      _CategoryTransactionCardState();
}

class _CategoryTransactionCardState extends State<CategoryTransactionCard> {
  final Set<TransactionModel> _expandedTransactions = {};

  String _formatDate(DateTime date, BuildContext context) {
    return DateFormat.yMMMd(Localizations.localeOf(context).languageCode)
        .add_jm()
        .format(date);
  }

  void _showEditDialog(BuildContext context, TransactionModel transaction) {
    final amountController = TextEditingController(
      text: transaction.amount.toString(),
    );
    final noteController = TextEditingController(text: transaction.note);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            S.of(context).editTransaction,
            style: AppStrings.font24BlackBoldWeight.copyWith(fontSize: 20.sp),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: S.of(context).amount),
              ),
              Gap(10.h),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: S.of(context).note),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () {
                final newAmount =
                    double.tryParse(amountController.text) ??
                    transaction.amount;
                final newNote = noteController.text.trim();

                final updatedTransaction = TransactionModel(
                  title: transaction.title,
                  category: transaction.category,
                  amount: newAmount,
                  note: newNote,
                  date: transaction.date,
                  image: transaction.image,
                );

                final currentList = List<TransactionModel>.from(
                  globalTransactions.value,
                );
                final index = currentList.indexOf(transaction);
                if (index != -1) {
                  currentList[index] = updatedTransaction;
                  globalTransactions.value = currentList;
                }
                Navigator.pop(context);
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = widget.transactions.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );

    final currencyFormat = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            spreadRadius: 0.6,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Section
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                /// Icon
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.teal.withValues(alpha: 0.2),
                  child:
                      widget.transactions.isNotEmpty &&
                          widget.transactions.first.image.isNotEmpty
                      ? Image.asset(
                          widget.transactions.first.image,
                          height: 24,
                          fit: BoxFit.contain,
                        )
                      : const Icon(Icons.category, color: Colors.teal),
                ),

                Gap(15.w),

                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getLocalizedCategory(context, widget.categoryName),
                        style: AppStrings.font24BlackBoldWeight.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        S.of(context).transactionsCount(widget.transactions.length),
                        style: AppStrings.font14grayRegular,
                      ),
                    ],
                  ),
                ),

                // Amount
                Text(
                  currencyFormat.format(totalAmount),
                  style: AppStrings.font18white700Weight.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Section
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: widget.transactions.map((transaction) {
                final isExpanded = _expandedTransactions.contains(transaction);
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        _expandedTransactions.remove(transaction);
                      } else {
                        _expandedTransactions.add(transaction);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            /// Title + date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.note.isNotEmpty
                                        ? transaction.note
                                        : getLocalizedCategory(context, transaction.category),
                                    style: AppStrings.font18white700Weight
                                        .copyWith(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                        ),
                                  ),
                                  Gap(5.h),
                                  Text(
                                    _formatDate(transaction.date, context),
                                    style: AppStrings.font14grayRegular,
                                  ),
                                ],
                              ),
                            ),

                            // Icons (Edit & Delete instead of amount)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueGrey,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      _showEditDialog(context, transaction),
                                ),
                                Gap(15.w),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    final currentList =
                                        List<TransactionModel>.from(
                                          globalTransactions.value,
                                        );
                                    currentList.remove(transaction);
                                    globalTransactions.value = currentList;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Taller/Expanded view
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          child: isExpanded
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).amount,
                                              style:
                                                  AppStrings.font14grayRegular,
                                            ),
                                            Text(
                                              currencyFormat.format(transaction.amount),
                                              style: AppStrings
                                                  .font14grayRegular
                                                  .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Gap(8.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).categorySingular,
                                              style:
                                                  AppStrings.font14grayRegular,
                                            ),
                                            Text(
                                              transaction.category,
                                              style: AppStrings
                                                  .font14grayRegular
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
