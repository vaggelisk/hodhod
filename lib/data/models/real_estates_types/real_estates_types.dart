class RealEstatesTypes {
  int? id;
  String? name;
  String? description;

  RealEstatesTypes({
    this.id,
    this.name,
    this.description,
  });

  factory RealEstatesTypes.fromJson(Map<String, dynamic> json) =>
      RealEstatesTypes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
