import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/feature/report/widget/categories_section.dart';
import 'package:spendwise/feature/report/widget/report_header.dart';
import 'package:spendwise/feature/report/widget/state_row.dart';
import 'package:spendwise/feature/report/widget/total_spending_card.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReportHeader(),
              Gap(20.h),
              TotalSpendingCard(),
              Gap(20.h),
              StatsRow(),
              Gap(20.h),
              CategoriesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
