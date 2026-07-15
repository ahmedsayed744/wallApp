import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/feature/category/view/category_view.dart';
import 'package:spendwise/feature/home/view/home_view.dart';
import 'package:spendwise/feature/report/view/report_view.dart';
import 'package:spendwise/feature/root/logic/navigation_cubit.dart';
import 'package:spendwise/feature/setting/view/setting_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spendwise/generated/l10n.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late PageController controller;
  final List<Widget> _screens = [
    HomeView(),
    CategoryView(),
    ReportView(),
    SettingView(),
  ];

  @override
  void initState() {
    super.initState();
    final initialIndex =
        (context.read<NavigationCubit>().state as NavigationInitial)
            .selectedIndex;
    controller = PageController(initialPage: initialIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationInitial) {
          currentIndex = state.selectedIndex;
        } else if (state is NavigationTabChanged) {
          currentIndex = state.selectedIndex;
        }

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            // Since we are on root, exit the app
            SystemNavigator.pop();
          },
          child: Scaffold(
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: _screens,
            ),

            // Bottom Nav Bar
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.neutralColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  context.read<NavigationCubit>().changeIndex(index);
                  controller.jumpToPage(index);
                },
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Color(0xFF2C3E50),
                unselectedItemColor: Colors.grey.shade700,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      currentIndex == 0
                          ? Icons.home_filled
                          : Icons.home_outlined,
                    ),
                    label: S.of(context).home,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      currentIndex == 1
                          ? Icons.category
                          : Icons.category_outlined,
                    ),
                    label: S.of(context).categorySingular,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      currentIndex == 2
                          ? CupertinoIcons.chart_bar_alt_fill
                          : CupertinoIcons.shopping_cart,
                    ),
                    label: S.of(context).report,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      currentIndex == 3
                          ? Icons.settings
                          : Icons.settings_outlined,
                    ),
                    label: S.of(context).settings,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
