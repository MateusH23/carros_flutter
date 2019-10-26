import 'dart:async';

import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carros_api.dart';

class CarrosBloc {

  final _streamController = StreamController<List<Carro>>();

  get controller => _streamController;
  Stream<List<Carro>> get stream => _streamController.stream;

  fetch(String tipo) async {
    try {
      List<Carro> listCarros = await CarrosApi.getCarros(tipo);
      _streamController.add(listCarros);
    } catch (error) {
      _streamController.addError(error);
    }
  }

  void dispose() {
    _streamController.close();
  }

}