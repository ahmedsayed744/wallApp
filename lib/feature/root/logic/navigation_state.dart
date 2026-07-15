part of 'navigation_cubit.dart';

abstract class NavigationState {}

class NavigationInitial extends NavigationState {
  final int selectedIndex;
  NavigationInitial(this.selectedIndex);
}

class NavigationTabChanged extends NavigationState {
  final int selectedIndex;
  NavigationTabChanged(this.selectedIndex);
}
