import '../models/usuario.dart';

/// Armazena os usuários cadastrados em memória.
/// Não usa Firebase nem persistência em disco, conforme orientação da atividade.
class UsuariosStore {
  UsuariosStore._interno();
  static final UsuariosStore instancia = UsuariosStore._interno();

  final List<Usuario> _usuarios = [
    // usuário de demonstração, para facilitar o teste sem precisar cadastrar
    Usuario(nome: 'Visitante', email: 'teste@teste.com', senha: '123456'),
  ];

  void cadastrar(Usuario usuario) {
    _usuarios.add(usuario);
  }

  bool emailJaCadastrado(String email) {
    return _usuarios.any((u) => u.email.toLowerCase() == email.toLowerCase());
  }

  /// Retorna o usuário se as credenciais forem válidas, ou null caso contrário.
  Usuario? autenticar(String email, String senha) {
    for (final usuario in _usuarios) {
      if (usuario.email.toLowerCase() == email.toLowerCase() &&
          usuario.senha == senha) {
        return usuario;
      }
    }
    return null;
  }
}
