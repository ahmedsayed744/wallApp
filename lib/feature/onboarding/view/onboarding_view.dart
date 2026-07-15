import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/core/routing/routs.dart';
import 'package:spendwise/feature/onboarding/models/onboarding_model.dart';
import 'package:spendwise/feature/onboarding/widget/bottom_back_skip.dart';
import 'package:spendwise/feature/onboarding/widget/circle_icon.dart';
import 'package:spendwise/feature/onboarding/widget/description_widget.dart';
import 'package:spendwise/generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/onboarding/logic/onboarding_cubit.dart';
import 'package:spendwise/core/storage/hive_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  List<OnboardingModel> _getOnboardingList(BuildContext context) {
    return [
      OnboardingModel(
        title: S.of(context).welcomeTitle1,
        description: S.of(context).welcomeDesc1,
        icon: Icons.account_balance_wallet_outlined,
        colors: AppColors.primaryColor,
      ),
      OnboardingModel(
        title: S.of(context).welcomeTitle2,
        description: S.of(context).welcomeDesc2,
        icon: Icons.pie_chart_outline,
        colors: AppColors.secondaryColor,
      ),
      OnboardingModel(
        title: S.of(context).welcomeTitle3,
        description: S.of(context).welcomeDesc3,
        icon: Icons.show_chart,
        colors: Color(0xFF9733EE),
      ),
    ];
  }

  final PageController _controller = PageController();

  void nextPage(BuildContext context, int currentIndex, int total) {
    if (currentIndex < total - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Set onboarding as completed
      HiveManager.setNotFirstTime();
      // Navigate to Home
      Navigator.pushReplacementNamed(context, Routs.rootView);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingList = _getOnboardingList(context);

    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is OnboardingInitial) {
            currentIndex = state.index;
          } else if (state is OnboardingPageIndex) {
            currentIndex = state.index;
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: onboardingList.length,
                      onPageChanged: (index) {
                        context.read<OnboardingCubit>().updateIndex(index);
                      },
                      itemBuilder: (context, index) {
                        final item = onboardingList[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Circle Icon
                            CircleIcon(item: item),

                            Gap(30.h),

                            // Title
                            Text(item.title,
                                style: AppStrings.font24BlackBoldWeight),

                            Gap(15.h),

                            // Description
                            Descriptionwidget(item: item),
                          ],
                        );
                      },
                    ),
                  ),

                  // Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingList.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(4).r,
                        width: currentIndex == index ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                      ),
                    ),
                  ),

                  Gap(30),

                  // Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () =>
                          nextPage(context, currentIndex, onboardingList.length),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2C3E50),
                        minimumSize: Size(double.infinity, 55.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14).r,
                        ),
                      ),
                      child: Text(
                        currentIndex == onboardingList.length - 1
                            ? S.of(context).getStarted
                            : S.of(context).next,
                        style: AppStrings.font18white700Weight,
                      ),
                    ),
                  ),

                  Gap(10.h),

                  // Bottom Row (Back + Skip)
                  BottomBackSkip(
                      currentIndex: currentIndex, controller: _controller),

                  Gap(20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
