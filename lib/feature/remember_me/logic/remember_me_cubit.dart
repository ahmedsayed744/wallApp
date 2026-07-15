import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendwise/core/storage/hive_manager.dart';
import 'package:spendwise/core/notifications/notification_service.dart';
import 'package:spendwise/feature/remember_me/logic/remember_me_state.dart';
import 'package:spendwise/feature/remember_me/model/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

class RememberMeCubit extends Cubit<RememberMeState> {
  RememberMeCubit() : super(RememberMeInitial());

  Future<void> loadTasks() async {
    emit(RememberMeLoading());
    try {
      final tasks = await HiveManager.loadTasks();
      emit(RememberMeLoaded(
        tasks: tasks,
        selectedDay: DateTime.now(),
        focusedDay: DateTime.now(),
      ));
    } catch (e) {
      emit(RememberMeError(e.toString()));
    }
  }

  Future<void> _saveTasks(List<TaskModel> tasks) async {
    await HiveManager.saveTasks(tasks);
  }

  Future<void> addTask(TaskModel task) async {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;

      // Ask for permission if it's the first task or if permissions not granted
      await NotificationService.requestPermissions();

      final newTasks = List<TaskModel>.from(currentState.tasks)..add(task);
      await _saveTasks(newTasks);
      await NotificationService.scheduleTaskNotification(task);
      emit(currentState.copyWith(tasks: newTasks));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;
      final newTasks =
          currentState.tasks.map((t) => t.id == task.id ? task : t).toList();
      await _saveTasks(newTasks);

      // Update notification
      await NotificationService.cancelNotification(task.id);
      if (!task.isCompleted) {
        await NotificationService.scheduleTaskNotification(task);
      }

      emit(currentState.copyWith(tasks: newTasks));
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;
      final newTasks = currentState.tasks.where((t) => t.id != taskId).toList();
      await _saveTasks(newTasks);
      await NotificationService.cancelNotification(taskId);
      emit(currentState.copyWith(tasks: newTasks));
    }
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;
      final tasks = List<TaskModel>.from(currentState.tasks);
      final index = tasks.indexWhere((t) => t.id == taskId);
      
      if (index != -1) {
        final t = tasks[index];
        final updated = t.copyWith(isCompleted: !t.isCompleted);
        tasks[index] = updated;
        
        await _saveTasks(tasks);
        
        if (updated.isCompleted) {
          await NotificationService.cancelNotification(t.id);
        } else {
          await NotificationService.scheduleTaskNotification(updated);
        }
        
        emit(currentState.copyWith(tasks: tasks));
      }
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;
      emit(currentState.copyWith(
          selectedDay: selectedDay, focusedDay: focusedDay));
    }
  }

  void onFormatChanged(CalendarFormat format) {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;
      emit(currentState.copyWith(calendarFormat: format));
    }
  }

  void updateFilter(String filter) {
    if (state is RememberMeLoaded) {
      final currentState = state as RememberMeLoaded;
      emit(currentState.copyWith(filter: filter));
    }
  }
}
