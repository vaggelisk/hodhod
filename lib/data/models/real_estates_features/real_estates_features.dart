import 'package:hodhod/data/models/real_estates_features/real_estates_features_children.dart';

class RealEstatesFeatures {
  int? id;
  String? name;
  dynamic childrenCount;
  dynamic realEstateTypeId;
  dynamic parentId;
  List<RealEstatesFeaturesChildren>? children;

  RealEstatesFeatures({
    this.id,
    this.name,
    this.childrenCount,
    this.realEstateTypeId,
    this.parentId,
    this.children,
  });

  factory RealEstatesFeatures.fromJson(Map<String, dynamic> json) =>
      RealEstatesFeatures(
        id: json["id"],
        name: json["name"],
        childrenCount: json["children_count"],
        realEstateTypeId: json["real_estate_type_id"],
        parentId: json["parent_id"],
        children: json["children"] != null
            ? List<RealEstatesFeaturesChildren>.from(json["children"]
                .map((x) => RealEstatesFeaturesChildren.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "children_count": childrenCount,
        "real_estate_type_id": realEstateTypeId,
        "parent_id": parentId,
        "children": List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}
