import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      tooltip: context.l10n.changeLanguage,
      style: IconButton.styleFrom(
        backgroundColor: Colors.black38,
        foregroundColor: Colors.white,
      ),
      icon: const Icon(Icons.language),
      onPressed: () => context.read<LocaleCubit>().toggle(),
    );
  }
}