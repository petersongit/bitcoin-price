import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String _valor = 'R\$ 0.00';
  String _url = 'https://blockchain.info/ticker';


  void _capturarPrecoBitcoin() async {
    Uri uri;
    http.Response response;
    Map<String, dynamic> bitcoin;
    final _formatadorMoeda = NumberFormat.currency(locale: "pt_BR",  symbol: "R\$", decimalDigits: 2);
    var a = Intl();


    uri = Uri.parse(_url);

    response = await http.get(uri);

    print(response.statusCode.toString() + ' ' + response.body);
    bitcoin = json.decode(response.body);

    _valor = bitcoin['BRL']['buy'].toString();


    setState(() {
      _valor = _formatadorMoeda.format(double.parse(_valor));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/bitcoin.png'),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                _valor,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: _capturarPrecoBitcoin,
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                child: Text('Atualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
