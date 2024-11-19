import '../countries/currency.dart';

class Finance {
  dynamic cost;
  double? oCost = 0;
  dynamic days;
  dynamic total;
  dynamic usdToAed;
  dynamic packageId;
  String? type;
  String? typeKey;
  Currency? currency;


  Finance({
    this.cost,
    this.days,
    this.total,
    this.usdToAed,
    this.packageId,
    this.type,
    this.typeKey,
    this.oCost,
    this.currency,
  });

  factory Finance.fromJson(Map<String, dynamic> json) => Finance(
    cost: json["cost"],
    days: json["days"],
    total: json["total"],
    usdToAed: json["usd_to_aed"],
    packageId: json["package_id"],
    type: json["type"],
    typeKey: json["type_key"],
    currency: json["currency"] != null
        ? Currency.fromJson(json["currency"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "cost": cost,
    "days": days,
    "total": total,
    "usd_to_aed": usdToAed,
    "package_id": packageId,
    "type": type,
    "type_key": typeKey,
    "currency": currency?.toJson(),
  };
}