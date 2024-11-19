import 'real_estates.dart';

class RealEstateData {
  // Pagination pagination;
  List<RealEstates>? items;

  RealEstateData({
    // this.pagination,
    this.items,
  });

  factory RealEstateData.fromJson(Map<String, dynamic> json) => RealEstateData(
        // pagination: Pagination.fromJson(json["pagination"]),
        items: List<RealEstates>.from(
            json["items"].map((x) => RealEstates.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "pagination": pagination.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
