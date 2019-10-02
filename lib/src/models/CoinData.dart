import 'Coin.dart';

class CoinData {
  String disclaimer;
  Map<dynamic, dynamic> bpi;

  CoinData({this.disclaimer, this.bpi});

  factory CoinData.fromJson(Map<String, dynamic> json) => new CoinData(
      disclaimer: json['disclaimer'],
      bpi: json['bpi']
  );

  Map<String, dynamic> toJson() => {
    "disclaimer": disclaimer,
    "bpi": bpi
  };
}