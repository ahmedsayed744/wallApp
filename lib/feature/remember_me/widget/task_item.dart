import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/feature/remember_me/logic/remember_me_cubit.dart';
import 'package:spendwise/feature/remember_me/model/task_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:spendwise/feature/remember_me/widget/add_task_bottom_sheet.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: task.isCompleted ? Colors.green.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          _buildPriorityIndicator(),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted ? Colors.grey : Colors.black,
                  ),
                ),
                if (task.description != null && task.description!.isNotEmpty) ...[
                  Gap(4.h),
                  Text(
                    task.description!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
                Gap(4.h),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14.sp, color: Colors.blueAccent),
                    Gap(4.w),
                    Text(
                      task.time.format(context),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (task.repeat != TaskRepeat.none) ...[
                      Gap(12.w),
                      Icon(Icons.repeat, size: 14.sp, color: Colors.orange),
                      Gap(4.w),
                      Text(
                        task.repeat == TaskRepeat.daily
                            ? S.of(context).daily
                            : S.of(context).weekly,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildPriorityIndicator() {
    Color color;
    switch (task.priority) {
      case TaskPriority.high:
        color = Colors.redAccent;
        break;
      case TaskPriority.medium:
        color = Colors.orangeAccent;
        break;
      case TaskPriority.low:
        color = Colors.greenAccent;
        break;
    }

    return Container(
      width: 6.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.isCompleted ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            context.read<RememberMeCubit>().toggleTaskCompletion(task.id);
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.grey),
          onSelected: (value) {
            if (value == 'edit') {
              _showEditTask(context);
            } else if (value == 'delete') {
              context.read<RememberMeCubit>().deleteTask(task.id);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  const Icon(Icons.edit, color: Colors.blueAccent, size: 20),
                  const Gap(8),
                  Text(S.of(context).edit),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                  const Gap(8),
                  Text(S.of(context).delete),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showEditTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<RememberMeCubit>(),
        child: AddTaskBottomSheet(task: task),
      ),
    );
  }
}
