import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_flutter_app/src/models/Coin.dart';
import 'package:simple_flutter_app/src/models/CoinData.dart';
import 'package:simple_flutter_app/src/ui/widget/CoinDisplay.dart';
import 'package:simple_flutter_app/src/ui/widget/CoinInput.dart';
import 'package:simple_flutter_app/src/ui/widget/HistoryDisplay.dart';

const String API_URL = 'https://api.coindesk.com/v1/bpi';
const String DATE_FORMAT = 'yyyy-MM-dd';
const int STATUS_CODE_OK = 200;

class BitcoinScreen extends StatefulWidget {
  BitcoinScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BitcoinScreenState createState() => _BitcoinScreenState();
}

class _BitcoinScreenState extends State<BitcoinScreen> {
  Coin coin;
  String disclaimer = '';
  Map<String, dynamic> history;

  void _onBitcoinChange(String value) {
    if (value.length == 3) {
      sendRequest(value);
    } else {
      setState(() {
        coin = null;
        disclaimer = '';
        history = null;
      });
    }
  }

  void sendRequest(String value) async {
    final Uri uri =
        Uri.parse(API_URL + '/currentprice/' + value.toUpperCase() + '.json');

    var request = await HttpClient().getUrl(uri);
    var response = await request.close(); // SEND REQUEST

    if (response.statusCode == STATUS_CODE_OK) {
      response.transform(Utf8Decoder()).listen((contents) {
        final Map<String, dynamic> jsonData = json.decode(contents);
        final CoinData coinData = CoinData.fromJson(jsonData);
        final Map<String, dynamic> coinMap = coinData.bpi[value.toUpperCase()];
        final Coin coin = Coin.fromJson(coinMap);

        setState(() {
          this.coin = coin;
          this.disclaimer = coinData.disclaimer;
        });
      });
    }

    getCoinHistory(value);
  }

  void getCoinHistory(String value) async {
    var now = new DateTime.now();
    var monthBeforeNow = now.subtract(new Duration(days: 30));

    final String nowFormat = new DateFormat(DATE_FORMAT).format(now);
    final String beforeFormat =
        new DateFormat(DATE_FORMAT).format(monthBeforeNow);

    final Uri uri = Uri.parse(API_URL +
        '/historical/close.json/?currency=${value.toUpperCase()}&start=${beforeFormat}&end=${nowFormat}');

    var request = await HttpClient().getUrl(uri);
    var response = await request.close(); // SEND REQUEST

    if (response.statusCode == STATUS_CODE_OK) {
      response.transform(Utf8Decoder()).listen((contents) {
        var data = json.decode(contents);

        this.setState(() {
            history = data['bpi'];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(child: CoinInput(onChange: this._onBitcoinChange)),
            CoinDisplay(coin: coin),
            HistoryDisplay(history: this.history),

            this.disclaimer == ''
                ? Container()
                : Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(15.0),
              width: 300,
              decoration: new BoxDecoration(
                color: Colors.amber,
                borderRadius: new BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Text(
                '${this.disclaimer}',
                textAlign: TextAlign.center,
                style:
                TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
              ),
            )
          ],
        )
      ),
    );
  }
}
