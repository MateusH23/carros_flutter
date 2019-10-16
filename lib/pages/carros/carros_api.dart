import 'package:carros/pages/carros/carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro{
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    await Future.delayed(Duration(seconds: 2));

    String url = "http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo";

    var response = await http.get(url);

    print("GET >> $url");

    String json = response.body;

    List list = convert.json.decode(json);
    final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}
