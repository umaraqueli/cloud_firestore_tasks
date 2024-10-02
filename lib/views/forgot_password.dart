import 'package:firebase_projetct/services/authentication_service.dart';
import 'package:firebase_projetct/widgets/snack_bar_widget.dart';
import 'package:firebase_projetct/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "Digite seu email e enviaremos  um link para você resetar sua senha",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: _emailController,
                  decoration: decoration("Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => requiredValidator(value, "o email"),
                )),
            SizedBox(height: 10),
            MaterialButton(
              onPressed: () {
                _authService.passwordReset(_emailController.text).then((erro) {
                  if (erro != null) {
                    snackBarWidget(
                        context: context, title: erro, isError: true);
                  } else {
                    snackBarWidget(
                        context: context,
                        title: "Link enviado com sucesso!",
                        isError: false);
                  }
                });
              },
              child: Text("Resetar senha"),
              color: Colors.deepPurple,
              textColor: Colors.white,
            )
          ],
        ));
  }
}
