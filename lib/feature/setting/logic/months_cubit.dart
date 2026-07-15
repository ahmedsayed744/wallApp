import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/feature/home/model/transaction_model.dart';
import 'package:spendwise/feature/monthly_summary/service/summary_storage_service.dart';
import 'package:spendwise/feature/setting/logic/months_state.dart';

class MonthsCubit extends Cubit<MonthsState> {
  MonthsCubit() : super(MonthsInitial());

  Future<void> loadSummaries() async {
    emit(MonthsLoading());
    try {
      final summaries = await SummaryStorageService.generateIfNeeded(
        globalTransactions.value,
      );
      emit(MonthsLoaded(summaries));
    } catch (e) {
      emit(MonthsError(e.toString()));
    }
  }
}
