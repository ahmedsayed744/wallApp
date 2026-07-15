import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final String amount;
  final String percent;
  final double progress;
  final String image;
  final Color color;

  CategoryModel({
    required this.title,
    required this.amount,
    required this.percent,
    required this.progress,
    required this.image,
    required this.color,
  });
}