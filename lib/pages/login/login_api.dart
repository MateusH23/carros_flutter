import 'dart:convert';

import 'package:carros/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(login, senha) async {
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {"username": login, "password": senha};

      // o post por padrao envia no formato form/urlenconded
      // Para enviar por json, tem que fazer a conversao para string
      String s = json.encode(params);

      var url = "http://carros-springboot.herokuapp.com/api/v2/login";
      var response = await http.post(url, body: s, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map responseMap = json.decode(response.body);

      if (response.statusCode != 200) {
        return ApiResponse.error(responseMap["error"]);
      }

      final user = Usuario.fromJson(responseMap);

      return ApiResponse.ok(user);
    } catch (error, exception) {
      print("Erro: $error, $exception");
      return ApiResponse.error("Não foi possível fazer o login!");
    }
  }
}
