import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/feature/monthly_summary/model/category_summary.dart';
import 'package:spendwise/feature/monthly_summary/widget/summary_pie_chart.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

/// A single row in the category breakdown list.
/// Shows the category icon, name, amount, percentage, and a coloured progress bar.
class CategoryBreakdownTile extends StatelessWidget {
  const CategoryBreakdownTile({
    super.key,
    required this.summary,
    required this.allCategories,
    required this.isTop,
  });

  final CategorySummary summary;

  /// All categories in the month (used to compute the chart color).
  final List<CategorySummary> allCategories;

  /// Whether this is the highest-spending category (gets a badge).
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    final color = colorForCategory(summary.category, allCategories);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isTop ? color.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: isTop
            ? Border.all(color: color.withValues(alpha: 0.35), width: 1.5)
            : Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Category icon
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: summary.image.isNotEmpty
                  ? Image.asset(
                      summary.image,
                      width: 26.w,
                      height: 26.h,
                      fit: BoxFit.contain,
                    )
                  : Icon(Icons.category, color: color, size: 22),
            ),
          ),

          SizedBox(width: 12.w),

          // Name + progress bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      getLocalizedCategory(context, summary.category),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                      ),
                    ),
                    if (isTop) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '🏆 ${S.of(context).top}',
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
                SizedBox(height: 5.h),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: summary.percentage / 100,
                    minHeight: 5.h,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Amount + percentage
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(summary.amount)}",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                '${summary.percentage.toStringAsFixed(1)}%',
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
    );
  }
}
