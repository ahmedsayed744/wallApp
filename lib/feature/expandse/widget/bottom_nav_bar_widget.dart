import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.amountController,
    required this.selectedCategory,
    required this.selectedCategoryImage,
    required this.noteController,
  });

  final TextEditingController amountController;
  final String selectedCategory;
  final String selectedCategoryImage;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16).r,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2C3E50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
          ),
          onPressed: () {
            final amount = double.tryParse(amountController.text) ?? 0;

            if (amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).pleaseEnterValidAmount)),
              );
              return;
            }

            if (selectedCategory.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).pleaseSelectCategory)),
              );
              return;
            }

            final model = TransactionModel(
              title: selectedCategory,
              category: selectedCategory,
              amount: amount,
              note: noteController.text,
              date: DateTime.now(),
              image: selectedCategoryImage,
            );

            Navigator.pop(context, model);
          },
          child: Text(S.of(context).addExpense, style: AppStrings.font18white700Weight),
        ),
      ),
    );
  }
}
