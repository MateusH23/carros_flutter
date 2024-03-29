import 'dart:convert' as convert;

import 'package:carros/util/prefs.dart';

class Usuario {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario(
      {this.login,
        this.nome,
        this.email,
        this.urlFoto,
        this.token,
        this.roles});

  Usuario.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  void save(){
    Map map = toJson();

    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario> get() async {
    String result = await Prefs.getString("user.prefs");

    if(result == ""){
      return null;
    }

    Map map = convert.json.decode(result);
    Usuario user = Usuario.fromJson(map);

    return user;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }

}
