import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure_message.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/validators.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/widgets/auth_scaffold.dart';
import 'package:streetbite/presentation/widgets/auth_switch_prompt.dart';
import 'package:streetbite/presentation/widgets/auth_text_field.dart';
import 'package:streetbite/presentation/widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().signUp(
          name: _nameController.text,
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
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.localized(l10n))),
          );
        }
      },
      child: AuthScaffold(
        heroHeightFactor: 0.28,
        title: l10n.signupTitle,
        subtitle: l10n.signupSubtitle,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthTextField(
                controller: _nameController,
                hint: l10n.fullNameHint,
                keyboardType: TextInputType.name,
                validator: (v) => Validators.fullName(v, l10n),
              ),
              const SizedBox(height: 16),
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
                validator: (v) => Validators.password(v, l10n),
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _confirmController,
                hint: l10n.confirmPasswordHint,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onSubmitted: _submit,
                validator: (v) => Validators.confirmPassword(
                  v,
                  _passwordController.text,
                  l10n,
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => PrimaryButton(
                  label: l10n.signupButton,
                  isLoading: state is AuthLoading,
                  onPressed: _submit,
                ),
              ),
              const SizedBox(height: 16),
              AuthSwitchPrompt(
                prompt: l10n.haveAccountPrompt,
                action: l10n.loginButton,
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}