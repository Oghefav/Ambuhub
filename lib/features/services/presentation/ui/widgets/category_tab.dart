import 'package:ambuhub/features/services/presentation/ui/widgets/category_selector.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final String label;
  final String value;
  final ValueNotifier<String> selectedCategory;

  const CategoryTab({
    super.key,
    required this.label,
    required this.value,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedCategory,
      builder: (context, selected, _) {
        return GestureDetector(
          onTap: () => selectedCategory.value = value,
          child: CategorySelector(
            categoryName: label,
            isSelected: selected == value,
          ),
        );
      },
    );
  }
}
