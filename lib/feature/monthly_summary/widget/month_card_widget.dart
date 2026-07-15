import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/feature/monthly_summary/model/monthly_summary_model.dart';
import 'package:spendwise/feature/monthly_summary/widget/summary_pie_chart.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

/// A tappable card that represents a single month's summary in the list view.
/// Shows: month + year label, total spent, top category, and an arrow.
class MonthCardWidget extends StatelessWidget {
  const MonthCardWidget({
    super.key,
    required this.summary,
    required this.onTap,
    required this.isCurrentMonth,
  });

  final MonthlySummaryModel summary;
  final VoidCallback onTap;

  /// Whether this card represents the current (in-progress) month.
  final bool isCurrentMonth;

  @override
  Widget build(BuildContext context) {
    // Format the month name, e.g. "April 2026"
    final date = DateTime(summary.year, summary.month);
    final monthName =
        DateFormat('MMMM yyyy', Localizations.localeOf(context).languageCode)
            .format(date);

    // Top-category color for the accent stripe.
    final topCat = summary.categories.isNotEmpty ? summary.categories.first : null;
    final accentColor = topCat != null
        ? colorForCategory(topCat.category, summary.categories)
        : const Color(0xFF7C3AED);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Colored left accent bar
                Container(width: 5.w, color: accentColor),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Month header row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      monthName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF2C3E50),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    if (isCurrentMonth) ...[
                                      SizedBox(width: 8.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF50C878),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          S.of(context).live,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  S.of(context).categoriesCount(summary.categories.length),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            // Total spent
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "-${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(summary.totalSpent)}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFE74C3C),
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                Text(
                                  S.of(context).totalSpent,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 14.h),

                        // Category mini-bar (top 3)
                        if (summary.categories.isNotEmpty)
                          _MiniCategoryBar(summary: summary),

                        SizedBox(height: 12.h),

                        // Bottom row: top category + arrow
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star_rounded,
                                    color: accentColor, size: 16),
                                SizedBox(width: 4.w),
                                Text(
                                  '${S.of(context).top}: ${getLocalizedCategory(context, summary.topCategory)}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).details,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade400,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(Icons.arrow_forward_ios,
                                    size: 13, color: Colors.grey.shade400),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A compact stacked progress bar showing the top 3 categories proportionally.
class _MiniCategoryBar extends StatelessWidget {
  const _MiniCategoryBar({required this.summary});

  final MonthlySummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final top = summary.categories.take(3).toList();
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 8.h,
        child: Row(
          children: top.map((cat) {
            final color = colorForCategory(cat.category, summary.categories);
            return Flexible(
              flex: (cat.percentage * 10).toInt(),
              child: Container(color: color),
            );
          }).toList(),
        ),
      ),
    );
  }
}
