import 'package:bolsas_universitarias/auth/auth.service.dart';
import 'package:bolsas_universitarias/components/spinner.dart';
import 'package:bolsas_universitarias/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = AuthService.instance;
  final _formKey = GlobalKey<FormState>();

  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = User.login(_userController.text, _passwordController.text);

    try {
      setState(() {
        loading = true;
      });
      await _authService.login(user);
      Navigator.of(context).popAndPushNamed('/');
    } on DioError catch (error) {
      print(error);
      String message = error.response?.statusCode == 401
          ? error.response?.data['message']
          : error.message;

      final snackBar = _buildSnackBar(message);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  SnackBar _buildSnackBar(final String text) {
    return SnackBar(content: Text(text));
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
                    controller: _userController,
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Por favor, digite um usuário'
                          : null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      label: Text('Senha'),
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Por favor, digite uma senha'
                          : null;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _login,
                    child: loading ? const Spinner() : const Text('ENTRAR'),
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
