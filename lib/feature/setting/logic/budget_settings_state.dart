abstract class BudgetSettingsState {}

class BudgetSettingsInitial extends BudgetSettingsState {
  final bool isEditing;
  BudgetSettingsInitial({this.isEditing = false});
}

class BudgetSettingsEditing extends BudgetSettingsState {
  final bool isEditing;
  BudgetSettingsEditing(this.isEditing);
}
