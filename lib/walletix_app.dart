import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/routing/app_router.dart';
import 'package:spendwise/core/routing/routs.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spendwise/feature/root/logic/navigation_cubit.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/locale_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spendwise/core/routing/navigator_key.dart';

class Walletix extends StatelessWidget {
  final AppRouter appRouter;
  final bool isFirstTime;
  const Walletix({super.key, required this.appRouter, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NavigationCubit())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (_, child) {
          return ValueListenableBuilder<Locale>(
            valueListenable: globalLocale,
            builder: (context, currentLocale, _) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Walletix',
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  useMaterial3: true,
                ),
                darkTheme: ThemeData.light(),
                themeMode: ThemeMode.light,
                initialRoute: isFirstTime
                    ? Routs.onBoardingView
                    : Routs.rootView,
                onGenerateRoute: appRouter.generateRoute,
                locale: currentLocale,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
