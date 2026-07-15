import 'dart:convert';
import 'package:spendwise/feature/monthly_summary/model/category_summary.dart';

/// Aggregated expense summary for a single calendar month (e.g. April 2026).
class MonthlySummaryModel {
  /// Calendar year (e.g. 2026).
  final int year;

  /// Calendar month (1 = January … 12 = December).
  final int month;

  /// Sum of all transaction amounts for this month.
  final double totalSpent;

  /// Per-category breakdown, sorted descending by amount.
  final List<CategorySummary> categories;

  /// Name of the highest-spending category.
  final String topCategory;

  const MonthlySummaryModel({
    required this.year,
    required this.month,
    required this.totalSpent,
    required this.categories,
    required this.topCategory,
  });

  // ── Convenience ────────────────────────────────────────────────────────────

  /// A unique storage key for this month, e.g. "2026-04".
  String get storageKey => '$year-${month.toString().padLeft(2, '0')}';

  // ── Serialisation ──────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'year': year,
        'month': month,
        'totalSpent': totalSpent,
        'topCategory': topCategory,
        'categories': categories.map((c) => c.toJson()).toList(),
      };

  factory MonthlySummaryModel.fromJson(Map<String, dynamic> json) =>
      MonthlySummaryModel(
        year: json['year'] as int,
        month: json['month'] as int,
        totalSpent: (json['totalSpent'] as num).toDouble(),
        topCategory: json['topCategory'] as String,
        categories: (json['categories'] as List<dynamic>)
            .map((e) => CategorySummary.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /// Encode a list of summaries to a JSON string.
  static String encodeList(List<MonthlySummaryModel> list) =>
      jsonEncode(list.map((m) => m.toJson()).toList());

  /// Decode a list of summaries from a JSON string.
  static List<MonthlySummaryModel> decodeList(String json) {
    final raw = jsonDecode(json) as List<dynamic>;
    return raw
        .map((e) => MonthlySummaryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
