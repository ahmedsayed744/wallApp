part of 'onboarding_cubit.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {
  final int index;
  OnboardingInitial(this.index);
}

class OnboardingPageIndex extends OnboardingState {
  final int index;
  OnboardingPageIndex(this.index);
}
