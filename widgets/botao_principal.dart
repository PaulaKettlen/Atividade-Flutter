import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Botão em formato de pílula, escuro, usado nas ações principais das telas.
class BotaoPrincipal extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const BotaoPrincipal({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.olivaEscuro,
          foregroundColor: AppColors.textoClaro,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
