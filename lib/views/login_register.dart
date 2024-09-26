import 'package:firebase_projetct/services/authentication_service.dart';
import 'package:firebase_projetct/widgets/snack_bar_widget.dart';
import 'package:firebase_projetct/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Criar conta'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Image.asset('assets/tasks.png',
                          height: 350), // Adicione a imagem
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: decoration("Nome"),
                              validator: (value) =>
                                  requiredValidator(value, "o nome"),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _emailController,
                              decoration: decoration("Login"),
                              validator: (value) =>
                                  requiredValidator(value, "o login"),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _passwordController,
                              decoration: decoration("Senha"),
                              obscureText: true,
                              validator: (value) =>
                                  requiredValidator(value, "a senha"),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  String name = _nameController.text;
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  _authService
                                      .registerUser(
                                          name: name,
                                          email: email,
                                          password: password)
                                      .then((value) {
                                    if (value != null) {
                                      snackBarWidget(
                                          context: context,
                                          title: value,
                                          isError: true);
                                    } else {
                                      snackBarWidget(
                                          context: context,
                                          title:
                                              'Cadastro Efetuado com sucesso!',
                                          isError: false);
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                              child: Text('Cadastrar'),
                            ),
                          ],
                        ),
                      )
                    ])))));
  }
}
