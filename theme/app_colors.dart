import 'package:flutter/material.dart';

/// Paleta de cores do app - tema "Oliva"
/// Verde oliva + branco, com pequenos detalhes em dourado/khaki
/// para diferenciar tarefas pendentes de concluídas.
class AppColors {
  static const Color oliva = Color(0xFF6B7F3A);
  static const Color olivaEscuro = Color(0xFF3F4D22);
  static const Color olivaClaro = Color(0xFFA8B96B);
  static const Color doiradoAccent = Color(0xFFC9A646);
  static const Color olivaConcluida = Color(0xFF4F6B2D);
  static const Color cinzaPendente = Color(0xFFB7B49C);
  static const Color fundoCreme = Color(0xFFF8F8F2);
  static const Color cardBranco = Color(0xFFFFFFFF);
  static const Color textoEscuro = Color(0xFF2E3620);
  static const Color textoClaro = Color(0xFFFFFFFF);

  static const LinearGradient gradientePrincipal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [olivaEscuro, oliva],
  );
}

class AppTheme {
  static ThemeData get tema {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.fundoCreme,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.oliva,
        primary: AppColors.oliva,
        secondary: AppColors.doiradoAccent,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textoEscuro,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textoEscuro,
        ),
      ),
    );
  }
}
