import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// Round category icons from the Figma Home screen. `null` means "All".
class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;

  static const Map<String, IconData> _icons = {
    'Beef': Icons.kebab_dining,
    'Breakfast': Icons.breakfast_dining,
    'Chicken': Icons.dinner_dining,
    'Dessert': Icons.icecream,
    'Goat': Icons.kebab_dining,
    'Lamb': Icons.kebab_dining,
    'Pasta': Icons.ramen_dining,
    'Pork': Icons.lunch_dining,
    'Seafood': Icons.set_meal,
    'Side': Icons.takeout_dining,
    'Starter': Icons.tapas,
    'Vegan': Icons.eco,
    'Vegetarian': Icons.eco,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = index == 0 ? null : categories[index - 1];
          return _CategoryTile(
            label: category ?? context.l10n.categoryAll,
            icon: category == null
                ? Icons.apps
                : _icons[category] ?? Icons.restaurant_menu,
            isSelected: category == selected,
            onTap: () => onSelected(category),
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? primary : primary.withValues(alpha: 0.12),
              ),
              child: Icon(icon, color: isSelected ? Colors.white : primary),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}