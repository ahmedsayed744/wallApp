import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/monthly_summary/model/monthly_summary_model.dart';
import 'package:spendwise/feature/monthly_summary/widget/category_breakdown_tile.dart';
import 'package:spendwise/feature/monthly_summary/widget/summary_pie_chart.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

/// Full-detail screen for a single month's expense summary.
///
/// Sections:
/// 1. Gradient header — month name + total spent
/// 2. Animated pie chart
/// 3. Legend / category breakdown list
class MonthlySummaryDetailView extends StatelessWidget {
  const MonthlySummaryDetailView({super.key, required this.summary});

  final MonthlySummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final date = DateTime(summary.year, summary.month);
    final monthName = DateFormat(
      'MMMM yyyy',
      Localizations.localeOf(context).languageCode,
    ).format(date);
    final isCurrentMonth = () {
      final now = DateTime.now();
      return summary.year == now.year && summary.month == now.month;
    }();

    // Top category gets the first slot after sorting is already done in model.
    final topCat = summary.categories.isNotEmpty
        ? summary.categories.first
        : null;
    final accentColor = topCat != null
        ? colorForCategory(topCat.category, summary.categories)
        : const Color(0xFF7C3AED);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // ── Sliver App Bar ─────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: const Color(0xFF2C3E50),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C3E50), Color(0xFF4A6FA5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 80.h, 24.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            monthName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                          if (isCurrentMonth) ...[
                            SizedBox(width: 10.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF50C878),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                S.of(context).live,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        S.of(context).totalSpent,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        "-${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(summary.totalSpent)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Highest-spending highlight card ──────────────────────
                  if (topCat != null)
                    _HighlightCard(
                      topCategory: getLocalizedCategory(
                        context,
                        topCat.category,
                      ),
                      topAmount: topCat.amount,
                      topPercentage: topCat.percentage,
                      accentColor: accentColor,
                      image: topCat.image,
                    ),

                  SizedBox(height: 20.h),

                  // ── Pie chart ────────────────────────────────────────────
                  _SectionTitle(title: S.of(context).spendingChart),
                  SizedBox(height: 12.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.r),
                    child: SummaryPieChart(
                      categories: summary.categories,
                      totalSpent: summary.totalSpent,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Category breakdown ───────────────────────────────────
                  _SectionTitle(title: S.of(context).spendingBreakdown),
                  SizedBox(height: 8.h),

                  ...summary.categories.map(
                    (cat) => CategoryBreakdownTile(
                      summary: cat,
                      allCategories: summary.categories,
                      isTop: cat.category == summary.topCategory,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Quick stats row ──────────────────────────────────────
                  _QuickStatsRow(summary: summary),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section title ─────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStrings.font24BlackBoldWeight.copyWith(fontSize: 17.sp),
    );
  }
}

// ── Highlight card ────────────────────────────────────────────────────────────

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.topCategory,
    required this.topAmount,
    required this.topPercentage,
    required this.accentColor,
    required this.image,
  });

  final String topCategory;
  final double topAmount;
  final double topPercentage;
  final Color accentColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor, accentColor.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: image.isNotEmpty
                  ? Image.asset(image, width: 32.w, height: 32.h)
                  : Icon(Icons.star_rounded, color: Colors.white, size: 28),
            ),
          ),
          SizedBox(width: 16.w),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🏆 ${S.of(context).highestSpending}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  topCategory,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(topAmount)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                '${topPercentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
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

// ── Quick stats row ───────────────────────────────────────────────────────────

class _QuickStatsRow extends StatelessWidget {
  const _QuickStatsRow({required this.summary});
  final MonthlySummaryModel summary;

  @override
  Widget build(BuildContext context) {
    // Calculate daily average based on days in month.
    final daysInMonth = DateTime(summary.year, summary.month + 1, 0).day;
    final dailyAvg = summary.totalSpent / daysInMonth;

    return Row(
      children: [
        _QuickStatCard(
          icon: Icons.category_rounded,
          label: S.of(context).categories,
          value: '${summary.categories.length}',
          color: const Color(0xFF7C3AED),
        ),
        SizedBox(width: 12.w),
        _QuickStatCard(
          icon: Icons.today_rounded,
          label: S.of(context).dailyAvg,
          value: NumberFormat.simpleCurrency(
            locale: Localizations.localeOf(context).toString(),
          ).format(dailyAvg),
          color: const Color(0xFF2C3E50),
        ),
        SizedBox(width: 12.w),
        _QuickStatCard(
          icon: Icons.flag_rounded,
          label: S.of(context).topCategory,
          value: getLocalizedCategory(context, summary.topCategory),
          color: const Color(0xFFE74C3C),
        ),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            SizedBox(height: 6.h),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Inter',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
