import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

enum TaskRepeat { none, daily, weekly }

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final TimeOfDay time;
  final TaskPriority priority;
  final TaskRepeat repeat;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.time,
    this.priority = TaskPriority.medium,
    this.repeat = TaskRepeat.none,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    TaskPriority? priority,
    TaskRepeat? repeat,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      priority: priority ?? this.priority,
      repeat: repeat ?? this.repeat,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'hour': time.hour,
      'minute': time.minute,
      'priority': priority.index,
      'repeat': repeat.index,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(hour: json['hour'], minute: json['minute']),
      priority: TaskPriority.values[json['priority'] ?? 1],
      repeat: TaskRepeat.values[json['repeat'] ?? 0],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
