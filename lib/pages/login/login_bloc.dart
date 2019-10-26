import 'dart:async';

import 'package:carros/api_response.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class LoginBloc {

  final _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(login, senha) async {

    _streamController.add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    _streamController.add(false);

    return response;
  }

  void dispose(){
    _streamController.close();
  }

}