import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/feature/monthly_summary/model/monthly_summary_model.dart';

import 'package:spendwise/feature/monthly_summary/view/monthly_summary_detail_view.dart';
import 'package:spendwise/feature/monthly_summary/widget/month_card_widget.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/generated/l10n.dart';

/// Screen that lists all available monthly summaries, most-recent first.
///
/// Summaries are auto-generated from [globalTransactions] each time this
/// screen is opened, so the user always sees fresh data.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/setting/logic/months_cubit.dart';
import 'package:spendwise/feature/setting/logic/months_state.dart';

/// Screen that lists all available monthly summaries, most-recent first.
class MonthsView extends StatelessWidget {
  const MonthsView({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return BlocProvider(
      create: (context) => MonthsCubit()..loadSummaries(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            S.of(context).monthlySummary,
            style: AppStrings.font24BlackBoldWeight.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          actions: [
            // Manual refresh button
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh_rounded),
                tooltip: S.of(context).refresh,
                onPressed: () => context.read<MonthsCubit>().loadSummaries(),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            BlocBuilder<MonthsCubit, MonthsState>(
              builder: (context, state) {
                if (state is MonthsLoaded) {
                  return _SummaryHeaderStrip(summaries: state.summaries);
                }
                return const _SummaryHeaderStrip(summaries: []);
              },
            ),
            Expanded(
              child: BlocBuilder<MonthsCubit, MonthsState>(
                builder: (context, state) {
                  if (state is MonthsLoading || state is MonthsInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF7C3AED),
                      ),
                    );
                  } else if (state is MonthsError) {
                    return Center(child: Text(state.message));
                  } else if (state is MonthsLoaded) {
                    final summaries = state.summaries;
                    if (summaries.isEmpty) {
                      return _EmptyState(
                        onRefresh: () => context.read<MonthsCubit>().loadSummaries(),
                      );
                    }
                    return RefreshIndicator(
                      color: const Color(0xFF7C3AED),
                      onRefresh: () => context.read<MonthsCubit>().loadSummaries(),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
                        itemCount: summaries.length,
                        itemBuilder: (context, index) {
                          final s = summaries[index];
                          final isCurrent =
                              s.year == now.year && s.month == now.month;
                          return MonthCardWidget(
                            summary: s,
                            isCurrentMonth: isCurrent,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MonthlySummaryDetailView(summary: s),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header strip ──────────────────────────────────────────────────────────────

class _SummaryHeaderStrip extends StatelessWidget {
  const _SummaryHeaderStrip({required this.summaries});

  final List<MonthlySummaryModel> summaries;

  @override
  Widget build(BuildContext context) {
    final totalMonths = summaries.length;
    final grandTotal =
        summaries.fold<double>(0, (sum, s) => sum + s.totalSpent);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2C3E50),
            Color(0xFF4A6FA5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatChip(
            icon: Icons.calendar_month_rounded,
            label: S.of(context).months,
            value: NumberFormat.decimalPattern(
              Localizations.localeOf(context).toString(),
            ).format(totalMonths),
          ),
          Container(width: 1, height: 36.h, color: Colors.white24),
          _StatChip(
            icon: Icons.account_balance_wallet_rounded,
            label: S.of(context).allTimeSpent,
            value: NumberFormat.simpleCurrency(
              locale: Localizations.localeOf(context).toString(),
            ).format(grandTotal),
          ),
          if (summaries.isNotEmpty) ...[
            Container(width: 1, height: 36.h, color: Colors.white24),
            _StatChip(
              icon: Icons.trending_up_rounded,
              label: S.of(context).avgPerMonth,
              value: NumberFormat.simpleCurrency(
                locale: Localizations.localeOf(context).toString(),
              ).format(grandTotal / totalMonths),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white60,
            fontSize: 10.sp,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insert_chart_outlined_rounded,
                size: 72, color: Colors.grey.shade300),
            SizedBox(height: 16.h),
            Text(
              S.of(context).noSummariesYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey.shade500,
                fontFamily: 'Inter',
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).refresh),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}