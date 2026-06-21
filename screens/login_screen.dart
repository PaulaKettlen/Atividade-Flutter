import 'package:flutter/material.dart';
import '../data/usuarios_store.dart';
import '../theme/app_colors.dart';
import '../widgets/botao_principal.dart';
import '../widgets/campo_texto.dart';
import 'calendario_screen.dart';
import 'cadastro_screen.dart';

/// Tela de login. Sem Firebase: autentica contra a lista em memória
/// de UsuariosStore.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _mensagemErro;

  void _entrar() {
    final usuario = UsuariosStore.instancia.autenticar(
      _emailController.text.trim(),
      _senhaController.text,
    );

    if (usuario == null) {
      setState(() {
        _mensagemErro = 'E-mail ou senha inválidos.';
      });
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => CalendarioScreen(usuario: usuario),
      ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppColors.cardBranco,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.checklist_rtl,
                      color: AppColors.oliva, size: 32),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Minhas Tarefas',
                  style: TextStyle(
                    color: AppColors.textoClaro,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
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
                BotaoPrincipal(texto: 'Entrar', onPressed: _entrar),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CadastroScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.textoClaro),
                      children: [
                        TextSpan(text: 'Não é cadastrado? '),
                        TextSpan(
                          text: 'Cadastre-se',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
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
