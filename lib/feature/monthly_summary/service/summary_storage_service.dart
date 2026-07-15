import 'package:spendwise/core/storage/local_storage.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/feature/monthly_summary/model/monthly_summary_model.dart';
import 'package:spendwise/feature/monthly_summary/service/summary_service.dart';

/// High-level storage service that wraps [LocalStorage] for monthly summaries.
///
/// Responsibilities:
/// - Load / save the complete list of [MonthlySummaryModel]s from SharedPrefs.
/// - Upsert a summary (insert new or replace existing for same month).
/// - Auto-generate summaries for any completed months not yet summarised.
class SummaryStorageService {
  const SummaryStorageService._();

  // ── Read ───────────────────────────────────────────────────────────────────

  /// Load all persisted summaries, sorted most-recent first.
  static List<MonthlySummaryModel> loadAll() {
    final raw = LocalStorage.loadMonthlySummaries();
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = MonthlySummaryModel.decodeList(raw);
      // Sort: most recent month first.
      list.sort((a, b) {
        final cmpYear = b.year.compareTo(a.year);
        return cmpYear != 0 ? cmpYear : b.month.compareTo(a.month);
      });
      return list;
    } catch (_) {
      return [];
    }
  }

  // ── Write ──────────────────────────────────────────────────────────────────

  /// Insert or replace a [MonthlySummaryModel] in the persisted list.
  static Future<void> upsert(MonthlySummaryModel summary) async {
    final current = loadAll();
    // Remove any existing entry for the same month.
    final updated = current
        .where((s) => !(s.year == summary.year && s.month == summary.month))
        .toList();
    updated.add(summary);
    await LocalStorage.saveMonthlySummaries(
        MonthlySummaryModel.encodeList(updated));
    // Record latest generated month for deduplication across cold starts.
    await LocalStorage.saveLastSummaryYearMonth(summary.storageKey);
  }

  // ── Auto-generation ────────────────────────────────────────────────────────

  /// Re-calculates all monthly summaries from the given transactions list.
  ///
  /// This ensures that deletions and modifications to past transactions
  /// are always reflected in the historical summaries.
  static Future<List<MonthlySummaryModel>> generateIfNeeded(
    List<TransactionModel> allTransactions,
  ) async {
    if (allTransactions.isEmpty) {
      await LocalStorage.saveMonthlySummaries(MonthlySummaryModel.encodeList([]));
      return [];
    }

    // 1. Identify all unique year-month pairs present in the transaction history.
    final Set<String> yearMonthKeys = {};
    for (final tx in allTransactions) {
      yearMonthKeys.add('${tx.date.year}-${tx.date.month}');
    }

    final List<MonthlySummaryModel> summaries = [];

    // 2. Generate a fresh summary for each month identified.
    for (final key in yearMonthKeys) {
      final parts = key.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);

      final summary = SummaryService.buildSummary(
        year: year,
        month: month,
        allTransactions: allTransactions,
      );
      if (summary != null) {
        summaries.add(summary);
      }
    }

    // 3. Sort: most recent month first.
    summaries.sort((a, b) {
      final cmpYear = b.year.compareTo(a.year);
      return cmpYear != 0 ? cmpYear : b.month.compareTo(a.month);
    });

    // 4. Perist the complete, up-to-date list.
    await LocalStorage.saveMonthlySummaries(
      MonthlySummaryModel.encodeList(summaries),
    );

    // Update last generated tracker for telemetry / cold start checks if needed.
    if (summaries.isNotEmpty) {
      await LocalStorage.saveLastSummaryYearMonth(summaries.first.storageKey);
    }

    return summaries;
  }
}
