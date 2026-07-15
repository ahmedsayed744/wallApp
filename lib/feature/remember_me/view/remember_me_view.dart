import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/feature/remember_me/logic/remember_me_cubit.dart';
import 'package:spendwise/feature/remember_me/logic/remember_me_state.dart';
import 'package:spendwise/feature/remember_me/widget/add_task_bottom_sheet.dart';
import 'package:spendwise/feature/remember_me/widget/task_item.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:spendwise/feature/remember_me/model/task_model.dart';

class RememberMeView extends StatelessWidget {
  const RememberMeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          S.of(context).rememberMe,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocBuilder<RememberMeCubit, RememberMeState>(
            builder: (context, state) {
              if (state is RememberMeLoaded) {
                return IconButton(
                  icon: Icon(
                    state.calendarFormat == CalendarFormat.month
                        ? Icons.calendar_view_month
                        : Icons.calendar_view_week,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    final newFormat =
                        state.calendarFormat == CalendarFormat.month
                        ? CalendarFormat.week
                        : CalendarFormat.month;
                    context.read<RememberMeCubit>().onFormatChanged(newFormat);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<RememberMeCubit, RememberMeState>(
        builder: (context, state) {
          if (state is RememberMeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RememberMeLoaded) {
            return Column(
              children: [
                _buildCalendar(context, state),
                _buildFilterChips(context, state),
                const Gap(10),
                Expanded(child: _buildTaskList(context, state)),
              ],
            );
          } else if (state is RememberMeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTask(context),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, RememberMeLoaded state) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: state.focusedDay,
        calendarFormat: state.calendarFormat,
        selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          context.read<RememberMeCubit>().onDaySelected(
            selectedDay,
            focusedDay,
          );
        },
        eventLoader: (day) {
          return state.tasks
              .where((task) => isSameDay(task.date, day))
              .toList();
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, RememberMeLoaded state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _filterChip(context, state, 'all', S.of(context).seeAll),
          Gap(8.w),
          _filterChip(context, state, 'today', S.of(context).today),
          Gap(8.w),
          _filterChip(context, state, 'week', S.of(context).thisWeek),
          Gap(8.w),
          _filterChip(context, state, 'month', S.of(context).thisMonth),
        ],
      ),
    );
  }

  Widget _filterChip(
    BuildContext context,
    RememberMeLoaded state,
    String value,
    String label,
  ) {
    final isSelected = state.filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          context.read<RememberMeCubit>().updateFilter(value);
        }
      },
      selectedColor: Colors.blueAccent.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.blueAccent : Colors.grey,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    );
  }

  Widget _buildTaskList(BuildContext context, RememberMeLoaded state) {
    List<TaskModel> filteredTasks;

    if (state.filter == 'all') {
      filteredTasks = state.tasksForSelectedDay;
    } else {
      // Filtering logic for the entire list based on the selected filter
      final now = DateTime.now();
      filteredTasks = state.tasks.where((task) {
        if (state.filter == 'today') {
          return isSameDay(task.date, now);
        } else if (state.filter == 'week') {
          final weekEnd = now.add(const Duration(days: 7));
          return task.date.isAfter(now.subtract(const Duration(days: 1))) &&
              task.date.isBefore(weekEnd);
        } else if (state.filter == 'month') {
          return task.date.month == now.month && task.date.year == now.year;
        }
        return true;
      }).toList();

      // Sort filtered tasks by date/time
      filteredTasks.sort((a, b) {
        final dateComp = a.date.compareTo(b.date);
        if (dateComp != 0) return dateComp;
        return (a.time.hour * 60 + a.time.minute).compareTo(
          b.time.hour * 60 + b.time.minute,
        );
      });
    }

    if (filteredTasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_note, size: 64.sp, color: Colors.grey[300]),
            Gap(16.h),
            Text(
              S.of(context).noTasks,
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        return TaskItem(task: filteredTasks[index]);
      },
    );
  }

  void _showAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<RememberMeCubit>(),
        child: const AddTaskBottomSheet(),
      ),
    );
  }
}
