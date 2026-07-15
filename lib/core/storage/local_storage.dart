import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  static const String _budgetKey = 'global_budget';
  static const String _transactionsKey = 'global_transactions';
  static const String _monthlySummariesKey = 'monthly_summaries';
  static const String _lastSummaryYearMonthKey = 'last_summary_year_month';
  static const String _tasksKey = 'remember_me_tasks';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveBudget(double budget) async {
    await _prefs.setDouble(_budgetKey, budget);
  }

  static double loadBudget() {
    return _prefs.getDouble(_budgetKey) ?? 0.0;
  }

  static Future<void> saveTransactions(String transactionsJson) async {
    await _prefs.setString(_transactionsKey, transactionsJson);
  }

  static String? loadTransactions() {
    return _prefs.getString(_transactionsKey);
  }

  static Future<void> saveLocale(String localeCode) async {
    await _prefs.setString('global_locale', localeCode);
  }

  static String? loadLocale() {
    return _prefs.getString('global_locale');
  }

  // ── Monthly Summaries ─────────────────────────────────────────────────────

  /// Persist the JSON-encoded list of all monthly summaries.
  static Future<void> saveMonthlySummaries(String json) async {
    await _prefs.setString(_monthlySummariesKey, json);
  }

  /// Load the persisted JSON string of monthly summaries, or null if none.
  static String? loadMonthlySummaries() {
    return _prefs.getString(_monthlySummariesKey);
  }

  /// Record the last year-month that was successfully summarised (e.g. '2026-03').
  static Future<void> saveLastSummaryYearMonth(String ym) async {
    await _prefs.setString(_lastSummaryYearMonthKey, ym);
  }

  /// Retrieve the last recorded summary year-month string.
  static String? loadLastSummaryYearMonth() {
    return _prefs.getString(_lastSummaryYearMonthKey);
  }

  // ── Tasks ─────────────────────────────────────────────────────────────────

  static Future<void> saveTasks(String tasksJson) async {
    await _prefs.setString(_tasksKey, tasksJson);
  }

  static String? loadTasks() {
    return _prefs.getString(_tasksKey);
  }
}
