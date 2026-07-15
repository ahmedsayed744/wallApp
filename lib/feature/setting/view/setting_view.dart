import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/feature/setting/widget/budget_settings_card.dart';
import 'package:spendwise/feature/setting/widget/copy_right_card.dart';
import 'package:spendwise/feature/setting/widget/language_card.dart';
import 'package:spendwise/feature/setting/widget/history_card.dart';
import 'package:spendwise/feature/setting/widget/profile_header.dart';
import 'package:spendwise/feature/setting/widget/remember_me_card.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            Gap(25.h),
            BudgetSettingsCard(),
            Gap(20.h),
            LanguageCard(),
            Gap(20.h),
            const RememberMeCard(),
            Gap(20.h),
            HistoryCard(),
            Gap(25.h),
            CopyRightCard(),
          ],
        ),
      ),
    );
  }
}
