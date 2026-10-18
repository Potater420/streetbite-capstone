import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/core/utils/validators.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_state.dart';
import 'package:streetbite/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:streetbite/features/auth/presentation/widgets/auth_switch_prompt.dart';
import 'package:streetbite/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:streetbite/features/auth/presentation/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
        } else if (state is AuthError) {
          context.showFailure(state.failure);
        }
      },
      child: AuthScaffold(
        title: l10n.loginTitle,
        subtitle: l10n.loginSubtitle,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthTextField(
                controller: _emailController,
                hint: l10n.emailHint,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => Validators.email(v, l10n),
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _passwordController,
                hint: l10n.passwordHint,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onSubmitted: _submit,
                validator: (v) => Validators.password(v, l10n),
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => PrimaryButton(
                  label: l10n.loginButton,
                  isLoading: state is AuthLoading,
                  onPressed: _submit,
                ),
              ),
              const SizedBox(height: 16),
              AuthSwitchPrompt(
                prompt: l10n.noAccountPrompt,
                action: l10n.signupButton,
                // Replacement keeps only one auth screen alive, so the
                // listeners can't fire twice.
                onTap: () => Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.signup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}