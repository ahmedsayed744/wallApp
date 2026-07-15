import 'package:spendwise/feature/monthly_summary/model/monthly_summary_model.dart';

abstract class MonthsState {}

class MonthsInitial extends MonthsState {}

class MonthsLoading extends MonthsState {}

class MonthsLoaded extends MonthsState {
  final List<MonthlySummaryModel> summaries;
  MonthsLoaded(this.summaries);
}

class MonthsError extends MonthsState {
  final String message;
  MonthsError(this.message);
}
