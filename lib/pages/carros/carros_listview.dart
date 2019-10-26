import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/pages/carros/carros_bloc.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;
  final _bloc = CarrosBloc();

  String get tipo => widget.tipo;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return TextError("Não foi possível buscar os carros!");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Card(
            color: Colors.grey[200],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ??
                          "https://imagensemoldes.com.br/wp-content/uploads/2018/01/Filme-Carros-Relampago-Mcqueen-1-1.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome ?? "Carro",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _onClickCarro(c);
                          },
                          child: Text(
                            "DETALHES",
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            "SHARE",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
