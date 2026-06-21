import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Campo de texto customizado usado nas telas de login e cadastro.
class CampoTexto extends StatelessWidget {
  final String rotulo;
  final TextEditingController controller;
  final bool senha;
  final TextInputType tipoTeclado;

  const CampoTexto({
    super.key,
    required this.rotulo,
    required this.controller,
    this.senha = false,
    this.tipoTeclado = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rotulo,
          style: const TextStyle(
            color: AppColors.textoClaro,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: senha,
          keyboardType: tipoTeclado,
          style: const TextStyle(color: AppColors.textoEscuro),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cardBranco,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
