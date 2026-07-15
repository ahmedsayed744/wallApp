import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/setting/logic/budget_settings_cubit.dart';
import 'package:spendwise/feature/setting/logic/budget_settings_state.dart';

class BudgetSettingsCard extends StatelessWidget {
  const BudgetSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetSettingsCubit(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0.7,
              blurRadius: 25,
            ),
          ],
        ),
        child: Column(children: [const BudgetItem()]),
      ),
    );
  }
}

class BudgetItem extends StatefulWidget {
  const BudgetItem({super.key});

  @override
  State<BudgetItem> createState() => _BudgetItemState();
}

class _BudgetItemState extends State<BudgetItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: globalBudget.value.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetSettingsCubit, BudgetSettingsState>(
      builder: (context, state) {
        bool isEditing = false;
        if (state is BudgetSettingsEditing) {
          isEditing = state.isEditing;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.secondaryColor,
                    size: 35,
                  ),
                  Gap(10.w),
                  Text(
                    S.of(context).budgetSettings,
                    style: AppStrings.font18white700Weight.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Gap(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).monthlyBudget,
                        style: AppStrings.font18white700Weight.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      Gap(5.h),
                      Text(
                        S.of(context).yourSpendingLimit,
                        style: AppStrings.font14grayRegular.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isEditing) {
                        final newBudget = double.tryParse(_controller.text);
                        if (newBudget != null && newBudget >= 0) {
                          globalBudget.value = newBudget;
                        } else {
                          _controller.text = globalBudget.value.toStringAsFixed(
                            2,
                          );
                        }
                        context.read<BudgetSettingsCubit>().setEditing(false);
                      } else {
                        _controller.text = globalBudget.value.toStringAsFixed(
                          2,
                        );
                        context.read<BudgetSettingsCubit>().setEditing(true);
                      }
                    },
                    child: Text(
                      isEditing ? S.of(context).save : S.of(context).edit,
                      style: AppStrings.font14grayRegular.copyWith(
                        color: AppColors.secondaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              ValueListenableBuilder<double>(
                valueListenable: globalBudget,
                builder: (context, budgetValue, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 22,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).currencySymbol} ",
                          style: AppStrings.font18white700Weight.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        isEditing
                            ? Expanded(
                                child: TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  style: AppStrings.font24BlackBoldWeight
                                      .copyWith(fontSize: 22.sp),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 22,
                                    ).r,
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onSubmitted: (value) {
                                    final newBudget = double.tryParse(value);
                                    if (newBudget != null && newBudget >= 0) {
                                      globalBudget.value = newBudget;
                                    } else {
                                      _controller.text = globalBudget.value
                                          .toStringAsFixed(2);
                                    }
                                    context
                                        .read<BudgetSettingsCubit>()
                                        .setEditing(false);
                                  },
                                ),
                              )
                            : Text(
                                NumberFormat.decimalPattern(
                                  Localizations.localeOf(context).toString(),
                                ).format(budgetValue),
                                style: AppStrings.font24BlackBoldWeight
                                    .copyWith(fontSize: 22.sp),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
