/// Modelo simples de usuário, usado apenas em memória
/// (sem Firebase, conforme orientação da atividade).
class Usuario {
  final String nome;
  final String email;
  final String senha;

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
  });
}
