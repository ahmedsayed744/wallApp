import 'package:flutter/material.dart';

import 'package:spendwise/core/routing/routs.dart';
import 'package:spendwise/generated/l10n.dart';

import 'package:spendwise/feature/setting/widget/setting_tile.dart';

class RememberMeCard extends StatelessWidget {
  const RememberMeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      icon: Icons.notifications_active_outlined,
      title: S.of(context).rememberMe,
      subtitle: Text(
        S.of(context).rememberMeDescription,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
      onTap: () {
        Navigator.pushNamed(context, Routs.rememberMeView);
      },
    );
  }
}
