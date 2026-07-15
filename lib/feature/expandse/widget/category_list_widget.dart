import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/feature/expandse/model/category_model.dart';
import 'package:spendwise/core/i18n/translation_helper.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<CategoryModel> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22).r,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final item = categories[index];
          return CategoryItem(
            item: item,
            isSelected: item.title == selectedCategory,
            onTap: () => onSelected(item.title),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 60.w,
                width: 60.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.teal.withValues(alpha: 0.2)
                      : Colors.grey.shade200,
                  border: isSelected
                      ? Border.all(color: Colors.teal, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Image.asset(
                    item.image,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // 🔴 Notification Dot
              if (item.hasNotification)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),

          Gap(10.h),

          Text(
            getLocalizedCategory(context, item.title),
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.teal : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
