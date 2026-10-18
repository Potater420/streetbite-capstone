import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/features/orders/domain/payments/card_details.dart';
import 'package:streetbite/features/orders/domain/payments/card_payment.dart';
import 'package:streetbite/features/orders/domain/payments/cash_payment.dart';
import 'package:streetbite/features/orders/domain/payments/payment_method.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_state.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_event.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_state.dart';
import 'package:streetbite/features/orders/presentation/blocs/checkout_cubit.dart';
import 'package:streetbite/features/orders/presentation/blocs/checkout_state.dart';
import 'package:streetbite/core/widgets/bottom_action_bar.dart';
import 'package:streetbite/features/orders/presentation/widgets/card_form.dart';
import 'package:streetbite/features/cart/presentation/widgets/order_summary.dart';
import 'package:streetbite/features/orders/presentation/widgets/payment_option_card.dart';
import 'package:streetbite/core/widgets/section_title.dart';

enum _PaymentChoice { cash, card }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  _PaymentChoice _choice = _PaymentChoice.cash;

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context, CartState cart) {
    final auth = context.read<AuthCubit>().state;
    if (auth is! Authenticated || cart.items.isEmpty) return;

    final PaymentMethod payment;
    if (_choice == _PaymentChoice.card) {
      if (!_formKey.currentState!.validate()) return;
      payment = CardPayment(
        CardDetails(
          number: _numberController.text,
          name: _nameController.text,
          expiry: _expiryController.text,
          cvv: _cvvController.text,
        ),
      );
    } else {
      payment = const CashPayment();
    }

    context.read<CheckoutCubit>().placeOrder(
      uid: auth.user.uid,
      items: cart.items,
      deliveryMode: cart.deliveryMode,
      payment: payment,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => sl<CheckoutCubit>(),
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.orderSuccess,
              ModalRoute.withName(AppRoutes.home),
              arguments: state.order,
            );
            context.read<CartBloc>().add(const CartCleared());
          } else if (state is CheckoutFailure) {
            context.showFailure(state.failure);
          }
        },
        builder: (context, checkoutState) {
          final cart = context.watch<CartBloc>().state;

          return Scaffold(
            appBar: AppBar(),
            body: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                SectionTitle(l10n.checkoutTitle),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    l10n.paymentMethodTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: PaymentOptionCard(
                            title: l10n.payCash,
                            subtitle: l10n.payCashSubtitle,
                            icon: Icons.payments_outlined,
                            isSelected: _choice == _PaymentChoice.cash,
                            onTap: () =>
                                setState(() => _choice = _PaymentChoice.cash),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PaymentOptionCard(
                            title: l10n.payCard,
                            subtitle: l10n.payCardSubtitle,
                            icon: Icons.credit_card,
                            isSelected: _choice == _PaymentChoice.card,
                            onTap: () =>
                                setState(() => _choice = _PaymentChoice.card),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_choice == _PaymentChoice.card)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Form(
                      key: _formKey,
                      child: CardForm(
                        numberController: _numberController,
                        nameController: _nameController,
                        expiryController: _expiryController,
                        cvvController: _cvvController,
                      ),
                    ),
                  ),
                const Divider(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OrderSummary(pricing: cart.pricing),
                ),
              ],
            ),
            bottomNavigationBar: BottomActionBar(
              label: l10n.placeOrderWithTotal(
                context.formatPrice(cart.pricing.total),
              ),
              isLoading: checkoutState is CheckoutProcessing,
              onPressed: () => _submit(context, cart),
            ),
          );
        },
      ),
    );
  }
}