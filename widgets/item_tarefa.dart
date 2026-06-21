import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../theme/app_colors.dart';

/// Representa uma linha de tarefa dentro da lista do dia.
class ItemTarefa extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback aoAlternar;
  final VoidCallback aoRemover;

  const ItemTarefa({
    super.key,
    required this.tarefa,
    required this.aoAlternar,
    required this.aoRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(tarefa.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => aoRemover(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cardBranco,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: aoAlternar,
              child: Icon(
                tarefa.concluida
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: tarefa.concluida
                    ? AppColors.olivaConcluida
                    : AppColors.cinzaPendente,
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tarefa.titulo,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textoEscuro,
                  decoration: tarefa.concluida
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: AppColors.textoEscuro,
                ),
              ),
            ),
            IconButton(
              onPressed: aoRemover,
              icon: const Icon(Icons.close, color: Colors.black26, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
