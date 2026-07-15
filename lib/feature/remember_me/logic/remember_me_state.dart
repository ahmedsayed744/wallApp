import 'package:spendwise/feature/remember_me/model/task_model.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class RememberMeState {}

class RememberMeInitial extends RememberMeState {}

class RememberMeLoading extends RememberMeState {}

class RememberMeLoaded extends RememberMeState {
  final List<TaskModel> tasks;
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final String filter; // 'today', 'week', 'month', 'all'

  RememberMeLoaded({
    required this.tasks,
    required this.selectedDay,
    required this.focusedDay,
    this.calendarFormat = CalendarFormat.month,
    this.filter = 'all',
  });

  RememberMeLoaded copyWith({
    List<TaskModel>? tasks,
    DateTime? selectedDay,
    DateTime? focusedDay,
    CalendarFormat? calendarFormat,
    String? filter,
  }) {
    return RememberMeLoaded(
      tasks: tasks ?? this.tasks,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      filter: filter ?? this.filter,
    );
  }

  List<TaskModel> get tasksForSelectedDay {
    return tasks.where((task) {
      return task.date.year == selectedDay.year &&
          task.date.month == selectedDay.month &&
          task.date.day == selectedDay.day;
    }).toList();
  }
}

class RememberMeError extends RememberMeState {
  final String message;
  RememberMeError(this.message);
}
