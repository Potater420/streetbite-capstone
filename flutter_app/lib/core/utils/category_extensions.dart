import 'package:flutter/widgets.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

extension CategoryNames on BuildContext {
  /// Translates a TheMealDB category for display. A category that isn't in
  /// the list keeps its API name, so a new one never breaks the UI.
  String categoryName(String category) {
    final l10n = this.l10n;
    return switch (category) {
      'Beef' => l10n.categoryBeef,
      'Breakfast' => l10n.categoryBreakfast,
      'Chicken' => l10n.categoryChicken,
      'Dessert' => l10n.categoryDessert,
      'Goat' => l10n.categoryGoat,
      'Lamb' => l10n.categoryLamb,
      'Miscellaneous' => l10n.categoryMiscellaneous,
      'Pasta' => l10n.categoryPasta,
      'Pork' => l10n.categoryPork,
      'Seafood' => l10n.categorySeafood,
      'Side' => l10n.categorySide,
      'Starter' => l10n.categoryStarter,
      'Vegan' => l10n.categoryVegan,
      'Vegetarian' => l10n.categoryVegetarian,
      _ => category,
    };
  }
}