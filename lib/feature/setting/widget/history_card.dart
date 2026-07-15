import 'package:flutter/material.dart';

import 'package:spendwise/feature/setting/view/months_view.dart';
import 'package:spendwise/generated/l10n.dart';

import 'package:spendwise/feature/setting/widget/setting_tile.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      icon: Icons.calendar_month,
      title: S.of(context).currentMonth,
      subtitle: Text(
        S.of(context).viewPastSpending,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MonthsView()),
        );
      },
    );
  }
}
