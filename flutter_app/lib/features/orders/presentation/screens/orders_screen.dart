import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/features/orders/presentation/blocs/orders_cubit.dart';
import 'package:streetbite/features/orders/presentation/blocs/orders_state.dart';
import 'package:streetbite/core/widgets/empty_state.dart';
import 'package:streetbite/features/orders/presentation/widgets/order_tile.dart';
import 'package:streetbite/core/widgets/screen_title.dart';

/// Live order history from Firestore, newest first.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<OrdersCubit, OrdersState>(
      listenWhen: (previous, current) => current.failure != null,
      listener: (context, state) => context.showFailure(state.failure!),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(l10n.ordersTitle),
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    if (!state.isLoaded) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.orders.isEmpty) {
                      return EmptyState(
                        icon: Icons.receipt_long_outlined,
                        message: l10n.ordersEmpty,
                      );
                    }
                    return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) =>
                          OrderTile(order: state.orders[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}