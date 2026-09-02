import 'package:flutter/material.dart';
import 'package:spendwise/core/routing/app_router.dart';
import 'package:spendwise/core/storage/local_storage.dart';
import 'package:spendwise/walletix_app.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/core/i18n/locale_manager.dart';
import 'package:spendwise/core/notifications/notification_service.dart';

import 'package:spendwise/core/storage/hive_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Essential initializations (Keep these fast)
  await LocalStorage.init();
  await HiveManager.init();

  // Load initial settings
  // bool isFirstTime = HiveManager.isFirstTime();

  // Load initial locale (from SharedPreferences for now, since it's already there)
  String? savedLocale = LocalStorage.loadLocale();
  if (savedLocale != null) {
    globalLocale.value = Locale(savedLocale);
  }

  // Load Budget
  globalBudget.value = LocalStorage.loadBudget();

  // Initialize notifications before runApp to handle launch payloads
  await NotificationService.init();

  runApp(Walletix(appRouter: AppRouter(), isFirstTime: false,));

  // Background Initializations (Non-blocking)
  _initServicesAsync();
}

Future<void> _initServicesAsync() async {
  // Trigger a test notification for verification (Remove in production)
  // await NotificationService.scheduleTestNotification();

  // Load Transactions in background
  final transactions = await HiveManager.loadTransactions();
  globalTransactions.value = transactions;

  // Setup Listeners to auto-save (Only after initial load)
  _setupAutoSave();
}

void _setupAutoSave() {
  globalBudget.addListener(() {
    LocalStorage.saveBudget(globalBudget.value);
  });

  globalTransactions.addListener(() async {
    await HiveManager.saveTransactions(globalTransactions.value);
  });

  globalLocale.addListener(() {
    LocalStorage.saveLocale(globalLocale.value.languageCode);
  });
}
