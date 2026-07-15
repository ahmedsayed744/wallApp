import 'package:flutter/material.dart';

import 'package:spendwise/core/i18n/locale_manager.dart';
import 'package:spendwise/generated/l10n.dart';

import 'package:spendwise/feature/setting/widget/setting_tile.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            S.of(context).selectLanguage,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<Locale>(
                valueListenable: globalLocale,
                builder: (context, currentLocale, _) {
                  return RadioGroup<String>(
                    groupValue: currentLocale.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        globalLocale.value = Locale(value);
                        Navigator.pop(context);
                      }
                    },
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text(S.of(context).english),
                          subtitle: const Text("English"),
                          value: 'en',
                          activeColor: const Color(0xFF7C3AED),
                        ),
                        RadioListTile<String>(
                          title: Text(S.of(context).arabic),
                          subtitle: const Text("العربية"),
                          value: 'ar',
                          activeColor: const Color(0xFF7C3AED),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.of(context).cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      icon: Icons.translate,
      title: S.of(context).selectLanguage,
      subtitle: ValueListenableBuilder<Locale>(
        valueListenable: globalLocale,
        builder: (context, locale, _) {
          return Text(
            locale.languageCode == 'ar' ? "الحالية: العربية" : "Current: English",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          );
        },
      ),
      onTap: () => _showLanguageDialog(context),
    );
  }
}
