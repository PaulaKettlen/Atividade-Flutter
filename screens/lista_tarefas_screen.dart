import 'package:flutter/material.dart';
import '../data/tarefas_store.dart';
import '../models/tarefa.dart';
import '../models/usuario.dart';
import '../theme/app_colors.dart';
import '../widgets/item_tarefa.dart';

/// Tela de lista de tarefas de um dia específico.
/// Pendentes aparecem primeiro (ordem alfabética), depois as concluídas
/// (também em ordem alfabética). Permite adicionar, remover e marcar
/// tarefas como concluídas.
class ListaTarefasScreen extends StatefulWidget {
  final Usuario usuario;
  final DateTime data;

  const ListaTarefasScreen({
    super.key,
    required this.usuario,
    required this.data,
  });

  @override
  State<ListaTarefasScreen> createState() => _ListaTarefasScreenState();
}

class _ListaTarefasScreenState extends State<ListaTarefasScreen> {
  late List<Tarefa> _tarefas;

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  void _carregarTarefas() {
    setState(() {
      _tarefas = TarefasStore.instancia.tarefasDoDiaOrdenadas(widget.data);
    });
  }

  void _alternarConcluida(Tarefa tarefa) {
    TarefasStore.instancia.alternarConcluida(widget.data, tarefa.id);
    _carregarTarefas();
  }

  void _removerTarefa(Tarefa tarefa) {
    TarefasStore.instancia.remover(widget.data, tarefa.id);
    _carregarTarefas();
  }

  Future<void> _abrirDialogoAdicionar() async {
    final controller = TextEditingController();

    final tituloDigitado = await showDialog<String>(
      context: context,
      builder: (contextoDialogo) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.cardBranco,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nova tarefa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoEscuro,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Ex: Estudar Flutter',
                    filled: true,
                    fillColor: AppColors.fundoCreme,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.olivaEscuro,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(contextoDialogo).pop(controller.text.trim());
                    },
                    child: const Text(
                      'Adicionar tarefa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (tituloDigitado != null && tituloDigitado.isNotEmpty) {
      TarefasStore.instancia.adicionar(widget.data, tituloDigitado);
      _carregarTarefas();
    }
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fundoCreme,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.olivaEscuro,
        onPressed: _abrirDialogoAdicionar,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem vindo,',
                    style: TextStyle(color: AppColors.oliva, fontSize: 20),
                  ),
                  Text(
                    '${widget.usuario.nome}!',
                    style: const TextStyle(
                      color: AppColors.olivaEscuro,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dia ${_formatarData(widget.data)}',
                    style: const TextStyle(
                      color: AppColors.textoEscuro,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.gradientePrincipal,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: _tarefas.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma tarefa para este dia.\nToque em + para adicionar.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _tarefas.length,
                        itemBuilder: (context, indice) {
                          final tarefa = _tarefas[indice];
                          return ItemTarefa(
                            tarefa: tarefa,
                            aoAlternar: () => _alternarConcluida(tarefa),
                            aoRemover: () => _removerTarefa(tarefa),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
