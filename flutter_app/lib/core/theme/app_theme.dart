import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streetbite/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    ).copyWith(primary: AppColors.primary, onPrimary: Colors.white);
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      // Poppins for Latin text. Poppins has no Arabic letters, so Cairo is
      // the fallback and takes over for them.
      textTheme: base.textTheme.apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontFamilyFallback: [GoogleFonts.cairo().fontFamily!],
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}