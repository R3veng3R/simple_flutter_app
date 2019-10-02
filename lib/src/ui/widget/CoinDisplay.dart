import 'package:flutter/cupertino.dart';
import 'package:simple_flutter_app/src/models/Coin.dart';

class CoinDisplay extends StatelessWidget {
  final Coin coin;

  CoinDisplay({this.coin});

  @override
  Widget build(BuildContext context) {
    if (coin == null) {
      return Text('No data to display.');
    } else {
      return Column(
        children: <Widget>[
          Text(
            '${coin.code}:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Text('Currency description: ${coin.description}'),
          Text('Current Rate: ${coin.rate_float}'),
        ],
      );
    }
  }
}
