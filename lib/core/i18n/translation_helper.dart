import 'package:flutter/widgets.dart';
import 'package:spendwise/generated/l10n.dart';

String getLocalizedCategory(BuildContext context, String category) {
  switch (category.toLowerCase()) {
    case 'food':
      return S.of(context).food;
    case 'transport':
      return S.of(context).transport;
    case 'shopping':
      return S.of(context).shopping;
    case 'bills':
      return S.of(context).bills;
    case 'health':
      return S.of(context).health;
    case 'entertainment':
      return S.of(context).entertainment;
    case 'education':
      return S.of(context).education;
    case 'other':
      return S.of(context).other;
    default:
      return category;
  }
}
