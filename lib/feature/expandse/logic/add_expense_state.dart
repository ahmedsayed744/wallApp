

abstract class AddExpenseState {}

class AddExpenseInitial extends AddExpenseState {
  final String selectedCategory;
  AddExpenseInitial({this.selectedCategory = ""});
}

class AddExpenseCategorySelected extends AddExpenseState {
  final String selectedCategory;
  AddExpenseCategorySelected(this.selectedCategory);
}
