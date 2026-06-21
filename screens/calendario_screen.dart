import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../theme/app_colors.dart';
import '../widgets/botao_principal.dart';
import 'lista_tarefas_screen.dart';

/// Tela de calendário: o usuário escolhe um dia e segue para a lista
/// de tarefas daquele dia.
class CalendarioScreen extends StatefulWidget {
  final Usuario usuario;

  const CalendarioScreen({super.key, required this.usuario});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  DateTime _diaSelecionado = DateTime.now();

  void _irParaListaDeTarefas() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListaTarefasScreen(
          usuario: widget.usuario,
          data: _diaSelecionado,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundoCreme,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem vindo,',
                style: TextStyle(
                  color: AppColors.oliva,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${widget.usuario.nome}!',
                style: const TextStyle(
                  color: AppColors.olivaEscuro,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppColors.gradientePrincipal,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.cardBranco,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.oliva,
                                onPrimary: Colors.white,
                              ),
                            ),
                            child: CalendarDatePicker(
                              initialDate: _diaSelecionado,
                              firstDate: DateTime(2020, 1, 1),
                              lastDate: DateTime(2100, 12, 31),
                              onDateChanged: (data) {
                                setState(() => _diaSelecionado = data);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      BotaoPrincipal(
                        texto: 'Selecionar o dia',
                        onPressed: _irParaListaDeTarefas,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
