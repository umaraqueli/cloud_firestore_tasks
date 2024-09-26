import 'package:firebase_projetct/widgets/text_form_field_widget.dart';
import 'package:firebase_projetct/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';

import '../services/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tela de Login'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/tasks.png', height: 250),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: decoration("Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => requiredValidator(value, "o email"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: decoration("Senha"),
                    obscureText: true,
                    validator: (value) => requiredValidator(value, "a senha"),
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          _authService
                              .loginUser(email: email, password: password)
                              .then((erro) {
                            if (erro != null) {
                              snackBarWidget(
                                  context: context, title: erro, isError: true);
                            }
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Entrar'),
                        ],
                      )),
                  FilledButton(
                      style:
                          FilledButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        _authService.signInWithGoogle().then((erro) {
                          if (erro != null) {
                            snackBarWidget(
                                context: context, title: erro, isError: true);
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          SizedBox(width: 10),
                          Text("Logar com o Google")
                        ],
                      )),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registrarUsuario');
                    },
                    child: Text(
                      'Ainda não tem uma conta? Registre-se agora',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
