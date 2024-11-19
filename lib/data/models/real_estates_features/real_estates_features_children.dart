class RealEstatesFeaturesChildren{
  int? id;
  String? name;
  dynamic childrenCount;
  dynamic realEstateTypeId;
  dynamic parentId;
  bool selected;

  RealEstatesFeaturesChildren({
    this.id,
    this.name,
    this.childrenCount,
    this.realEstateTypeId,
    this.parentId,
    this.selected = false,
  });

  factory RealEstatesFeaturesChildren.fromJson(Map<String, dynamic> json) => RealEstatesFeaturesChildren(
    id: json["id"],
    name: json["name"],
    childrenCount: json["children_count"],
    realEstateTypeId: json["real_estate_type_id"],
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "children_count": childrenCount,
    "real_estate_type_id": realEstateTypeId,
    "parent_id": parentId,
  };
}