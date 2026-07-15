import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/setting/logic/budget_settings_state.dart';

class BudgetSettingsCubit extends Cubit<BudgetSettingsState> {
  BudgetSettingsCubit() : super(BudgetSettingsInitial());

  void toggleEditing() {
    bool currentIsEditing = false;
    if (state is BudgetSettingsInitial) {
      currentIsEditing = (state as BudgetSettingsInitial).isEditing;
    } else if (state is BudgetSettingsEditing) {
      currentIsEditing = (state as BudgetSettingsEditing).isEditing;
    }
    emit(BudgetSettingsEditing(!currentIsEditing));
  }

  void setEditing(bool editing) {
    emit(BudgetSettingsEditing(editing));
  }
}
