import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_state.dart';

/// Cart icon with a live item-count badge.
class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key, required this.onPressed, this.style});

  final VoidCallback onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.totalCount != current.totalCount,
      builder: (context, state) => IconButton(
        tooltip: context.l10n.cartTooltip,
        style: style,
        onPressed: onPressed,
        icon: Badge(
          isLabelVisible: state.totalCount > 0,
          label: Text('${state.totalCount}'),
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }
}
