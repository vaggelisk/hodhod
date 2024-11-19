class Price {
  double? fromPrice;
  double? toPrice;

  Price({
    this.fromPrice,
    this.toPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        fromPrice: json["from_price"],
        toPrice: json["to_price"],
      );

  Map<String, dynamic> toJson() => {
        "from_price": fromPrice,
        "to_price": toPrice,
      };
}
