import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/widgets/hot_offer_card.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';

/// Horizontal "Hot Offers" list (five items).
class HotOffersSection extends StatelessWidget {
  const HotOffersSection({super.key, required this.meals});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(context.l10n.hotOffersTitle),
        SizedBox(
          height: 252,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: meals.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => HotOfferCard(meal: meals[index]),
          ),
        ),
      ],
    );
  }
}