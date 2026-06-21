import 'package:flutter/material.dart';
import '../data/usuarios_store.dart';
import '../models/usuario.dart';
import '../theme/app_colors.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_texto.dart';

/// Tela de cadastro de novo usuário (em memória, sem Firebase).
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _mensagemErro;

  void _cadastrar() {
    final nome = _nomeController.text.trim();
    final email = _emailController.text.trim();
    final senha = _senhaController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      setState(() => _mensagemErro = 'Preencha todos os campos.');
      return;
    }

    if (UsuariosStore.instancia.emailJaCadastrado(email)) {
      setState(() => _mensagemErro = 'Este e-mail já está cadastrado.');
      return;
    }

    UsuariosStore.instancia.cadastrar(
      Usuario(nome: nome, email: email, senha: senha),
    );

    Navigator.of(context).pop(); // volta para a tela de login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado! Faça login.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.gradientePrincipal),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Criar conta',
                  style: TextStyle(
                    color: AppColors.textoClaro,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 28),
                CampoTexto(rotulo: 'Nome', controller: _nomeController),
                CampoTexto(
                  rotulo: 'E-mail',
                  controller: _emailController,
                  tipoTeclado: TextInputType.emailAddress,
                ),
                CampoTexto(
                  rotulo: 'Senha',
                  controller: _senhaController,
                  senha: true,
                ),
                if (_mensagemErro != null) ...[
                  Text(
                    _mensagemErro!,
                    style: const TextStyle(color: Colors.yellowAccent),
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 8),
                BotaoPrincipal(texto: 'Cadastrar', onPressed: _cadastrar),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Já tenho conta',
                    style: TextStyle(color: AppColors.textoClaro),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
