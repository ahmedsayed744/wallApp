import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/report/model/category_model.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final List<Map<String, dynamic>> categoryTemplates = [
    {
      "title": "Food",
      "image": "assets/images/category/food.png",
      "color": Colors.blue,
    },
    {
      "title": "Transport",
      "image": "assets/images/category/transport.png",
      "color": Colors.purple,
    },
    {
      "title": "Shopping",
      "image": "assets/images/category/shopping.png",
      "color": Colors.green,
    },
    {
      "title": "Bills",
      "image": "assets/images/category/bill.png",
      "color": Colors.grey,
    },
    {
      "title": "Health",
      "image": "assets/images/category/health.png",
      "color": Colors.red,
    },
    {
      "title": "Entertainment",
      "image": "assets/images/category/Entertainment.png",
      "color": Colors.pink,
    },
    {
      "title": "Education",
      "image": "assets/images/category/education.png",
      "color": Colors.yellow,
    },
    {
      "title": "Other",
      "image": "assets/images/category/other.png",
      "color": Colors.black,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).categories,
              style: AppStrings.font24BlackBoldWeight.copyWith(fontSize: 22.sp),
            ),
            Text(
              S.of(context).viewDetails,
              style: AppStrings.font14grayRegular.copyWith(color: Colors.blue),
            ),
          ],
        ),

        Gap(15.h),

        /// List
        ValueListenableBuilder<List<TransactionModel>>(
          valueListenable: globalTransactions,
          builder: (context, transactions, _) {
            double totalSpent = transactions.fold(
              0,
              (sum, item) => sum + item.amount,
            );

            List<CategoryModel> displayCategories = [];

            for (var template in categoryTemplates) {
              double categorySpent = transactions
                  .where((t) => t.category == template["title"])
                  .fold(0, (sum, item) => sum + item.amount);

              if (categorySpent > 0) {
                double progress = totalSpent > 0
                    ? (categorySpent / totalSpent)
                    : 0.0;
                final percentFormat = NumberFormat.percentPattern(Localizations.localeOf(context).toString());
                final currencyFormat = NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString());
                String percent = percentFormat.format(progress);
                String amountStr = currencyFormat.format(categorySpent);

                displayCategories.add(
                  CategoryModel(
                    title: template["title"],
                    amount: amountStr,
                    percent: percent,
                    progress: progress,
                    image: template["image"],
                    color: template["color"],
                  ),
                );
              }
            }

            // sort by spent amount descending
            displayCategories.sort((a, b) => b.progress.compareTo(a.progress));

            if (displayCategories.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    S.of(context).noExpensesYet,
                    style: AppStrings.font14grayRegular,
                  ),
                ),
              );
            }

            return SafeArea(
              child: ListView.builder(
                itemCount: displayCategories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CategoryItem(model: displayCategories[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.model});

  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: model.color.withValues(alpha: 0.1),
            child: Center(
              child: Image.asset(model.image, width: 25.w, height: 25.h),
            ),
          ),
          Gap(10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getLocalizedCategory(context, model.title), style: AppStrings.font14grayRegular),
                    Text(model.amount, style: AppStrings.font14grayRegular),
                  ],
                ),

                Gap(5.h),

                /// Progress
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: model.progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(model.color),
                  ),
                ),

                Gap(5.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    model.percent,
                    style: AppStrings.font14grayRegular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
