import 'package:hive_flutter/hive_flutter.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/feature/remember_me/model/task_model.dart';
import 'package:spendwise/core/storage/local_storage.dart';
import 'dart:convert';

class HiveManager {
  static const String _settingsBoxName = 'settings_box';
  static const String _transactionsBoxName = 'transactions_box';
  static const String _tasksBoxName = 'tasks_box';
  static const String _isFirstTimeKey = 'is_first_time';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Open essential boxes
    await Hive.openBox(_settingsBoxName);

    // Migration from SharedPreferences to Hive
    await _migrateIfNeeded();
  }

  static Future<void> _migrateIfNeeded() async {
    if (settingsBox.get('migrated_to_hive', defaultValue: false)) return;

    // Migrate Transactions
    String? txJson = LocalStorage.loadTransactions();
    if (txJson != null) {
      final box = await openTransactionsBox();
      await box.put('all_transactions', txJson);
    }

    // Migrate Tasks
    String? tasksJson = LocalStorage.loadTasks();
    if (tasksJson != null) {
      final box = await openTasksBox();
      await box.put('all_tasks', tasksJson);
    }

    // Set migration flag
    await settingsBox.put('migrated_to_hive', true);
  }

  /// Lazy loading transactions box only when needed
  static Future<Box<String>> openTransactionsBox() async {
    return await Hive.openBox<String>(_transactionsBoxName);
  }

  /// Lazy loading tasks box only when needed
  static Future<Box<String>> openTasksBox() async {
    return await Hive.openBox<String>(_tasksBoxName);
  }

  static Box get settingsBox => Hive.box(_settingsBoxName);

  // ── Settings Gate ─────────────────────────────────────────────────────────

  static bool isFirstTime() {
    return settingsBox.get(_isFirstTimeKey, defaultValue: true);
  }

  static Future<void> setNotFirstTime() async {
    await settingsBox.put(_isFirstTimeKey, false);
  }

  // ── Transactions ──────────────────────────────────────────────────────────
  
  static Future<void> saveTransactions(List<TransactionModel> transactions) async {
    final box = await openTransactionsBox();
    final jsonList = transactions.map((e) => e.toJson()).toList();
    await box.put('all_transactions', jsonEncode(jsonList));
  }

  static Future<List<TransactionModel>> loadTransactions() async {
    final box = await openTransactionsBox();
    final String? txJson = box.get('all_transactions');
    if (txJson != null) {
      try {
        List<dynamic> decoded = jsonDecode(txJson);
        return decoded.map((e) => TransactionModel.fromJson(e)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // ── Tasks ───────────────────────────────────────────────────────────────

  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final box = await openTasksBox();
    final jsonList = tasks.map((e) => e.toJson()).toList();
    await box.put('all_tasks', jsonEncode(jsonList));
  }

  static Future<List<TaskModel>> loadTasks() async {
    final box = await openTasksBox();
    final String? tasksJson = box.get('all_tasks');
    if (tasksJson != null) {
      try {
        List<dynamic> decoded = jsonDecode(tasksJson);
        return decoded.map((e) => TaskModel.fromJson(e)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }
}
