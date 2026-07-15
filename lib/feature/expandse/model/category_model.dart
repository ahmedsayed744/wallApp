class CategoryModel {
  final String title;
  final String image;
  final bool hasNotification;

  CategoryModel({
    required this.title,
    required this.image,
    this.hasNotification = false,
  });
}