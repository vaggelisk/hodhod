import 'currency.dart';

class Countries {
  int? id;
  String? name;
  String? code;
  String? phoneCode;
  String? flag;
  dynamic currencyId;
  Currency? currency;

  Countries({
    this.id,
    this.name,
    this.code,
    this.phoneCode,
    this.flag,
    this.currencyId,
    this.currency,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        phoneCode: json["phone_code"],
        flag: json["flag"],
        currencyId: json["currency_id"],
        currency: json["currency"] != null
            ? Currency.fromJson(json["currency"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "phone_code": phoneCode,
        "flag": flag,
        "currency_id": currencyId,
        "currency": currency?.toJson(),
      };
}
