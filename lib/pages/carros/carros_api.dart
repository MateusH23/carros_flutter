import 'package:carros/pages/carros/carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    await Future.delayed(Duration(seconds: 2));

    String url = "http://carros-springboot.herokuapp.com/api/v1/carros";

    var response = await http.get(url);

    String json = response.body;

    List list = convert.json.decode(json);
    final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}