import '../models/tarefa.dart';

/// Armazena as tarefas em memória, organizadas por dia.
/// A chave do mapa é uma string no formato 'yyyy-MM-dd'.
class TarefasStore {
  TarefasStore._interno();
  static final TarefasStore instancia = TarefasStore._interno();

  final Map<String, List<Tarefa>> _tarefasPorDia = {};

  String _chave(DateTime data) {
    final ano = data.year.toString().padLeft(4, '0');
    final mes = data.month.toString().padLeft(2, '0');
    final dia = data.day.toString().padLeft(2, '0');
    return '$ano-$mes-$dia';
  }

  /// Adiciona uma nova tarefa ao dia informado.
  /// Por padrão, toda tarefa nasce como não concluída.
  void adicionar(DateTime data, String titulo) {
    final chave = _chave(data);
    _tarefasPorDia.putIfAbsent(chave, () => []);
    _tarefasPorDia[chave]!.add(
      Tarefa(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        titulo: titulo,
        concluida: false,
      ),
    );
  }

  void remover(DateTime data, String id) {
    final chave = _chave(data);
    _tarefasPorDia[chave]?.removeWhere((tarefa) => tarefa.id == id);
  }

  void alternarConcluida(DateTime data, String id) {
    final chave = _chave(data);
    final tarefas = _tarefasPorDia[chave];
    if (tarefas == null) return;
    for (final tarefa in tarefas) {
      if (tarefa.id == id) {
        tarefa.concluida = !tarefa.concluida;
        break;
      }
    }
  }

  /// Retorna as tarefas do dia já ordenadas:
  /// 1) pendentes primeiro (ordem alfabética)
  /// 2) concluídas depois (ordem alfabética)
  List<Tarefa> tarefasDoDiaOrdenadas(DateTime data) {
    final chave = _chave(data);
    final tarefas = List<Tarefa>.from(_tarefasPorDia[chave] ?? []);

    final pendentes = tarefas.where((t) => !t.concluida).toList()
      ..sort((a, b) => a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase()));

    final concluidas = tarefas.where((t) => t.concluida).toList()
      ..sort((a, b) => a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase()));

    return [...pendentes, ...concluidas];
  }
}
