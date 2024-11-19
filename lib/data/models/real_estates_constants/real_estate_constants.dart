class RealEstateConstants {
  String? key;
  String? name;

  RealEstateConstants({
    this.key,
    this.name,
  });

  factory RealEstateConstants.fromJson(Map<String, dynamic> json) =>
      RealEstateConstants(
        key: json["key"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
      };
}
