class Language{
  int? id;
  String? name;
  String? symbol;
  bool selected;

  Language({
    this.id,
    this.name,
    this.symbol,
    this.selected = false,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
  };
}