import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/expandse/model/category_model.dart';
import 'package:spendwise/feature/expandse/widget/add_note_widget.dart';
import 'package:spendwise/feature/expandse/widget/amount_header_widget.dart';
import 'package:spendwise/feature/expandse/widget/bottom_nav_bar_widget.dart';
import 'package:spendwise/feature/expandse/widget/category_list_widget.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/expandse/logic/add_expense_cubit.dart';
import 'package:spendwise/feature/expandse/logic/add_expense_state.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<CategoryModel> categories = [
    CategoryModel(title: "Food", image: "assets/images/category/food.png"),
    CategoryModel(
      title: "Transport",
      image: "assets/images/category/transport.png",
      hasNotification: true,
    ),
    CategoryModel(
      title: "Shopping",
      image: "assets/images/category/shopping.png",
    ),
    CategoryModel(title: "Bills", image: "assets/images/category/bill.png"),
    CategoryModel(title: "Health", image: "assets/images/category/health.png"),
    CategoryModel(
      title: "Entertainment",
      image: "assets/images/category/Entertainment.png",
    ),
    CategoryModel(
      title: "Education",
      image: "assets/images/category/education.png",
    ),
    CategoryModel(title: "Other", image: "assets/images/category/other.png"),
  ];

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExpenseCubit(),
      child: BlocBuilder<AddExpenseCubit, AddExpenseState>(
        builder: (context, state) {
          String selectedCategory = "";
          if (state is AddExpenseInitial) {
            selectedCategory = state.selectedCategory;
          } else if (state is AddExpenseCategorySelected) {
            selectedCategory = state.selectedCategory;
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF2C3E50),
              foregroundColor: Colors.white,
              title: Text(
                S.of(context).addExpense,
                style: AppStrings.font24BlackBoldWeight.copyWith(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Amount HEADER
                  AmountHederWidget(amountController: amountController),

                  Gap(20.h),

                  /// CATEGORY GRID
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22).r,
                    child: Row(
                      children: [
                        Text(
                          S.of(context).selectCategory,
                          style: AppStrings.font24BlackBoldWeight,
                        ),
                      ],
                    ),
                  ),
                  Gap(20.h),
                  // Category List
                  CategoryListWidget(
                    categories: categories,
                    selectedCategory: selectedCategory,
                    onSelected: (newValue) {
                      context.read<AddExpenseCubit>().selectCategory(newValue);
                      noteController.text =
                          "${S.of(context).selectCategory}: ${getLocalizedCategory(context, newValue)}";
                    },
                  ),
                  Gap(20.h),

                  // Add Note
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22).r,
                    child: Row(
                      children: [
                        Text(
                          S.of(context).addNoteOptional,
                          style: AppStrings.font24BlackBoldWeight,
                        ),
                      ],
                    ),
                  ),
                  Gap(15.h),
                  AddNoteWidget(noteController: noteController),
                  Gap(20.h),

                  /// BUTTON
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBarWidget(
              amountController: amountController,
              selectedCategory: selectedCategory,
              selectedCategoryImage: selectedCategory.isEmpty
                  ? ""
                  : categories
                      .firstWhere(
                        (c) => c.title == selectedCategory,
                        orElse: () => categories.first,
                      )
                      .image,
              noteController: noteController,
            ),
          );
        },
      ),
    );
  }
}
