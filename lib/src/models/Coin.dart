class Coin {
  String code;
  String rate;
  String description;
  double rate_float;

  Coin({this.code, this.rate, this.description, this.rate_float});

  factory Coin.fromJson(Map<String, dynamic> json) => new Coin(
      code: json['code'],
      rate: json['rate'],
      description: json['description'],
      rate_float: json['rate_float']
  );
}