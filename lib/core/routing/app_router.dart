import 'package:flutter/material.dart';
import 'package:spendwise/feature/category/view/category_view.dart';
import 'package:spendwise/feature/home/view/home_view.dart';
import 'package:spendwise/feature/onboarding/view/onboarding_view.dart';
import 'package:spendwise/feature/report/view/report_view.dart';
import 'package:spendwise/feature/setting/view/setting_view.dart';
import 'package:spendwise/feature/remember_me/view/remember_me_view.dart';
import 'package:spendwise/feature/remember_me/logic/remember_me_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/root/view/root_view.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/routing/routs.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case '/HomeView':
        return MaterialPageRoute(builder: (_) => const HomeView());

      case '/CategoryView':
        return MaterialPageRoute(builder: (_) => const CategoryView());

      case '/ReportView':
        return MaterialPageRoute(builder: (_) => const ReportView());

      case Routs.settingView:
        return MaterialPageRoute(builder: (_) => const SettingView());
      case Routs.rememberMeView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RememberMeCubit()..loadTasks(),
            child: const RememberMeView(),
          ),
        );
      case Routs.rootView:
        return MaterialPageRoute(builder: (_) => const RootView());
      case '/OnboardingView':
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(S.of(context).noRouteDefined(settings.name ?? '')),
            ),
          ),
        );
    }
  }
}
