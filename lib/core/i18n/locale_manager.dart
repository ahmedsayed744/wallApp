import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

final ValueNotifier<Locale> globalLocale = ValueNotifier(_getInitialLocale());

Locale _getInitialLocale() {
  final platformLocale = WidgetsBinding.instance.platformDispatcher.locale;
  if (platformLocale.languageCode == 'ar') {
    return const Locale('ar');
  }
  return const Locale('en');
}
