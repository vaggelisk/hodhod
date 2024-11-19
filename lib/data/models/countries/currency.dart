class Currency {
  int? id;
  String? name;
  String? symbol;
  String? code;
  String? icon;
  String? exchangeRate;

  Currency({
    this.id,
    this.name,
    this.symbol,
    this.code,
    this.icon,
    this.exchangeRate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        code: json["code"],
        icon: json["icon"],
        exchangeRate: json["exchange_rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "code": code,
        "icon": icon,
        "exchange_rate": exchangeRate,
      };
}
