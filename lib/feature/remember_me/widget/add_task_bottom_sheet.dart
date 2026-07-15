import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/feature/remember_me/logic/remember_me_cubit.dart';
import 'package:spendwise/feature/remember_me/model/task_model.dart';
import 'package:spendwise/generated/l10n.dart';
import 'package:uuid/uuid.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final TaskModel? task;
  const AddTaskBottomSheet({super.key, this.task});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late TaskPriority _selectedPriority;
  late TaskRepeat _selectedRepeat;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task?.title ?? '';
    _descController.text = widget.task?.description ?? '';
    _selectedDate = widget.task?.date ?? DateTime.now();
    _selectedTime = widget.task?.time ?? TimeOfDay.now();
    _selectedPriority = widget.task?.priority ?? TaskPriority.medium;
    _selectedRepeat = widget.task?.repeat ?? TaskRepeat.none;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Gap(20.h),
              Text(
                widget.task == null ? S.of(context).addTask : S.of(context).editTask,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Gap(20.h),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: S.of(context).title,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? S.of(context).titleRequired : null,
              ),
              Gap(15.h),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  labelText: S.of(context).description,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
                ),
                maxLines: 2,
              ),
              Gap(15.h),
              _buildDateTimeSection(),
              Gap(15.h),
              _buildRepeatSection(),
              Gap(15.h),
              _buildPrioritySection(),
              Gap(30.h),
              _buildSubmitButton(context),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRepeatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).priority, // Using priority style for repeat label
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: TaskRepeat.values.map((repeat) {
            final isSelected = _selectedRepeat == repeat;
            String text;
            switch (repeat) {
              case TaskRepeat.none:
                text = S.of(context).none;
                break;
              case TaskRepeat.daily:
                text = S.of(context).daily;
                break;
              case TaskRepeat.weekly:
                text = S.of(context).weekly;
                break;
            }
            return ChoiceChip(
              label: Text(text),
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedRepeat = repeat),
              selectedColor: Colors.blueAccent.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected ? Colors.blueAccent : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today, color: Colors.blueAccent),
            title: Text(S.of(context).date),
            subtitle: Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
            onTap: _pickDate,
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time, color: Colors.blueAccent),
            title: Text(S.of(context).time),
            subtitle: Text(_selectedTime.format(context)),
            onTap: _pickTime,
          ),
        ),
      ],
    );
  }

  Widget _buildPrioritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).priority, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: TaskPriority.values.map((priority) {
            final isSelected = _selectedPriority == priority;
            Color color;
            String text;
            switch (priority) {
              case TaskPriority.low:
                color = Colors.green;
                text = S.of(context).low;
                break;
              case TaskPriority.medium:
                color = Colors.orange;
                text = S.of(context).medium;
                break;
              case TaskPriority.high:
                color = Colors.red;
                text = S.of(context).high;
                break;
            }
            return ChoiceChip(
              label: Text(text),
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedPriority = priority),
              selectedColor: color.withValues(alpha: 0.3),
              labelStyle: TextStyle(color: isSelected ? color : Colors.black),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final task = TaskModel(
              id: widget.task?.id ?? const Uuid().v4(),
              title: _titleController.text,
              description: _descController.text,
              date: _selectedDate,
              time: _selectedTime,
              priority: _selectedPriority,
              repeat: _selectedRepeat,
              isCompleted: widget.task?.isCompleted ?? false,
            );
            if (widget.task == null) {
              context.read<RememberMeCubit>().addTask(task);
            } else {
              context.read<RememberMeCubit>().updateTask(task);
            }
            Navigator.pop(context);
          }
        },
        child: Text(
          S.of(context).save,
          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) setState(() => _selectedTime = time);
  }
}
