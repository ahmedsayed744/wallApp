import 'package:flutter/material.dart';
import 'package:spendwise/core/theme/app_strings.dart';
import 'package:spendwise/feature/onboarding/models/onboarding_model.dart';

class Descriptionwidget extends StatelessWidget {
  const Descriptionwidget({super.key, required this.item});

  final OnboardingModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        item.description,
        textAlign: TextAlign.center,
        style: AppStrings.font14grayRegular,
      ),
    );
  }
}
