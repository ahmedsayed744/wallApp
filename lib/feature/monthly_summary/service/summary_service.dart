import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/feature/monthly_summary/model/category_summary.dart';
import 'package:spendwise/feature/monthly_summary/model/monthly_summary_model.dart';

/// Pure-Dart service responsible for computing monthly summaries.
/// Contains no Flutter / UI imports — fully unit-testable.
class SummaryService {
  const SummaryService._();

  // ── Category → default asset image mapping ─────────────────────────────────

  /// Returns the asset image path for a given category name.
  /// Falls back to the "other" image for unknown categories.
  static String imageForCategory(String category) {
    const map = {
      'Food': 'assets/images/category/food.png',
      'Transport': 'assets/images/category/transport.png',
      'Shopping': 'assets/images/category/shopping.png',
      'Bills': 'assets/images/category/bill.png',
      'Health': 'assets/images/category/health.png',
      'Entertainment': 'assets/images/category/Entertainment.png',
      'Education': 'assets/images/category/education.png',
      'Other': 'assets/images/category/other.png',
    };
    return map[category] ?? 'assets/images/category/other.png';
  }

  // ── Core calculation ────────────────────────────────────────────────────────

  /// Builds a [MonthlySummaryModel] for the given [year] / [month]
  /// by aggregating only the transactions that fall in that month.
  ///
  /// Returns `null` if there are no transactions for that month.
  static MonthlySummaryModel? buildSummary({
    required int year,
    required int month,
    required List<TransactionModel> allTransactions,
  }) {
    // 1. Filter transactions that belong to this year-month.
    final filtered = allTransactions.where((t) {
      return t.date.year == year && t.date.month == month;
    }).toList();

    if (filtered.isEmpty) return null;

    // 2. Aggregate per category.
    final Map<String, double> totals = {};
    final Map<String, String> images = {};

    for (final tx in filtered) {
      totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
      // Always use the first seen image for this category; fallback to map.
      images[tx.category] ??=
          tx.image.isNotEmpty ? tx.image : imageForCategory(tx.category);
    }

    // 3. Compute grand total.
    final totalSpent = totals.values.fold<double>(0, (a, b) => a + b);

    // 4. Build CategorySummary list, sorted descending by amount.
    final categories = totals.entries.map((e) {
      final pct = totalSpent > 0 ? (e.value / totalSpent * 100) : 0.0;
      return CategorySummary(
        category: e.key,
        image: images[e.key]!,
        amount: e.value,
        percentage: pct,
      );
    }).toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    // 5. Identify top category.
    final topCategory = categories.first.category;

    return MonthlySummaryModel(
      year: year,
      month: month,
      totalSpent: totalSpent,
      categories: categories,
      topCategory: topCategory,
    );
  }

}
