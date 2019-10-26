import 'dart:async';

import 'package:carros/api_response.dart';
import 'package:carros/pages/carros/home_page.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/alert.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    Future<Usuario> usuario = Usuario.get();
    usuario.then((user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Carros",
        ),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite seu email",
              controller: _tLogin,
              // ignore: missing_return
              validator: _validateLogin,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Digite sua senha",
              obscure: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;
    print("Login: $login, Senha: $senha");

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      push(context, HomePage(), replace: true);
      print(">>> ${response.result} <<<");
    } else {
      alert(context, response.msg);
    }


  }

  // ignore: missing_return
  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
  }

  // ignore: missing_return
  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }

    if (text.length < 3) {
      return "Senha deve possuir no mínimo 3 dígitos";
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
