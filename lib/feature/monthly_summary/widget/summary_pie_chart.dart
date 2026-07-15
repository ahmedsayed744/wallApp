import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';
import 'package:spendwise/feature/monthly_summary/model/category_summary.dart';
import 'package:spendwise/generated/l10n.dart';

/// Color palette for the pie chart slices. Rotates via modulo.
const List<Color> _kSliceColors = [
  Color(0xFF7C3AED), // purple
  Color(0xFF2C3E50), // dark blue
  Color(0xFF50C878), // green
  Color(0xFFE74C3C), // red
  Color(0xFFF39C12), // amber
  Color(0xFF3498DB), // blue
  Color(0xFF1ABC9C), // teal
  Color(0xFFE67E22), // orange
];

/// Maps a category name to a deterministic chart color.
Color colorForCategory(String category, List<CategorySummary> allCategories) {
  final idx = allCategories.indexWhere((c) => c.category == category);
  return _kSliceColors[(idx < 0 ? 0 : idx) % _kSliceColors.length];
}

/// Animated pie chart widget driven by a list of [CategorySummary] entries.
class SummaryPieChart extends StatefulWidget {
  const SummaryPieChart({
    super.key,
    required this.categories,
    required this.totalSpent,
  });

  final List<CategorySummary> categories;
  final double totalSpent;

  @override
  State<SummaryPieChart> createState() => _SummaryPieChartState();
}

class _SummaryPieChartState extends State<SummaryPieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Pie chart ──────────────────────────────────────────────────────
          PieChart(
            PieChartData(
              sections: _buildSections(),
              centerSpaceRadius: 68.r,
              sectionsSpace: 3,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      _touchedIndex = -1;
                      return;
                    }
                    _touchedIndex =
                        response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
            ),
          ),

          // ── Center label ───────────────────────────────────────────────────
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_touchedIndex >= 0 &&
                  _touchedIndex < widget.categories.length) ...[
                Text(
                  getLocalizedCategory(context, widget.categories[_touchedIndex].category),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  NumberFormat.simpleCurrency(
                    locale: Localizations.localeOf(context).toString(),
                  ).format(widget.categories[_touchedIndex].amount),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: colorForCategory(
                        widget.categories[_touchedIndex].category,
                        widget.categories),
                    fontFamily: 'Inter',
                  ),
                ),
              ] else ...[
                Text(
                  S.of(context).total,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  NumberFormat.simpleCurrency(
                    locale: Localizations.localeOf(context).toString(),
                  ).format(widget.totalSpent),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    return List.generate(widget.categories.length, (i) {
      final cat = widget.categories[i];
      final isTouched = i == _touchedIndex;
      final color = colorForCategory(cat.category, widget.categories);
      return PieChartSectionData(
        value: cat.amount,
        color: color,
        radius: isTouched ? 68.r : 58.r,
        title: '${cat.percentage.toStringAsFixed(0)}%',
        titleStyle: TextStyle(
          fontSize: isTouched ? 13.sp : 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
        showTitle: cat.percentage >= 5,
        badgeWidget: null,
      );
    });
  }
}
