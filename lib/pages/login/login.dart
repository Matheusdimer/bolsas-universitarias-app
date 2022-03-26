import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _login() {
    Navigator.of(context).pushNamed('/', arguments: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login do aluno'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('lib/assets/unesc-logo.png'),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Usuário'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Senha'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text(
                      'ENTRAR',
                      textScaleFactor: 1.2,
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
