/// Spending breakdown for a single category inside a monthly summary.
class CategorySummary {
  /// E.g. "Food", "Transport"
  final String category;

  /// Asset image path (e.g. "assets/images/category/food.png")
  final String image;

  /// Total amount spent in this category for the month.
  final double amount;

  /// Percentage of this category out of the total monthly spend (0–100).
  final double percentage;

  const CategorySummary({
    required this.category,
    required this.image,
    required this.amount,
    required this.percentage,
  });

  /// Serialise to JSON for SharedPreferences persistence.
  Map<String, dynamic> toJson() => {
        'category': category,
        'image': image,
        'amount': amount,
        'percentage': percentage,
      };

  /// Deserialise from JSON.
  factory CategorySummary.fromJson(Map<String, dynamic> json) =>
      CategorySummary(
        category: json['category'] as String,
        image: json['image'] as String,
        amount: (json['amount'] as num).toDouble(),
        percentage: (json['percentage'] as num).toDouble(),
      );
}
