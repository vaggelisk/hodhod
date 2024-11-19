class Regions{
  int? id;
  String? name;
  dynamic cityId;

  Regions({
    this.id,
    this.name,
    this.cityId,
  });

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
    id: json["id"],
    name: json["name"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city_id": cityId,
  };
}