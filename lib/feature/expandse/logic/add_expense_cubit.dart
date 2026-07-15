import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/expandse/logic/add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseInitial());

  void selectCategory(String category) {
    emit(AddExpenseCategorySelected(category));
  }
}
