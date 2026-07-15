import 'package:flutter/foundation.dart';

class TransactionModel {
  final String title;
  final String category;
  final double amount;
  final String note;
  final DateTime date;
  final String image;

  TransactionModel({
    required this.title,
    required this.category,
    required this.amount,
    required this.note,
    required this.date,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'amount': amount,
      'note': note,
      'date': date.toIso8601String(),
      'image': image,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      title: json['title'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      note: json['note'] as String,
      date: DateTime.parse(json['date'] as String),
      image: json['image'] as String,
    );
  }
}

final ValueNotifier<List<TransactionModel>> globalTransactions = ValueNotifier(
  [],
);

final ValueNotifier<double> globalBudget = ValueNotifier(0.0);
