import 'package:hodhod/data/models/real_estates_constants/real_estate_constants.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';

class SearchFilter {
  List<RealEstateConstants>? realEstateStatus;
  List<RealEstateConstants>? type;
  List<RealEstateConstants>? transactionType;
  List<RealEstateConstants>? typeStatus;
  List<RealEstatesTypes>? realEstateTypes;

  // List<Categories>? subCategories;
  // Price price;
  List<int>? numberOfRooms;
  List<int>? numberOfBathrooms;

  List<RealEstatesFeatures>? featuresIds;
  List<RealEstateConstants>? sortBy;
  List<String>? multiSelect;

  SearchFilter({
    this.realEstateStatus,
    this.realEstateTypes,
    this.type,
    this.transactionType,
    this.typeStatus,
    // this.subCategories,
    // this.price,
    this.numberOfRooms,
    this.numberOfBathrooms,
    this.featuresIds,
    this.sortBy,
    this.multiSelect,
  });

  factory SearchFilter.fromJson(Map<String, dynamic> json) => SearchFilter(
        realEstateStatus: json["real_estate_status"] != null
            ? List<RealEstateConstants>.from(json["real_estate_status"]
                .map((x) => RealEstateConstants.fromJson(x)))
            : [],
        realEstateTypes: json["real_estate_types"] != null
            ? List<RealEstatesTypes>.from(json["real_estate_types"]
                .map((x) => RealEstatesTypes.fromJson(x)))
            : [],
        type: json["type"] != null
            ? List<RealEstateConstants>.from(
                json["type"].map((x) => RealEstateConstants.fromJson(x)))
            : [],
        transactionType: json["transaction_type"] != null
            ? List<RealEstateConstants>.from(json["transaction_type"]
                .map((x) => RealEstateConstants.fromJson(x)))
            : [],
        typeStatus: json["type_status"] != null
            ? List<RealEstateConstants>.from(
                json["type_status"].map((x) => RealEstateConstants.fromJson(x)))
            : [],
        // subCategories: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
        // price: Price.fromJson(json["price"]),
        numberOfRooms: json["number_of_rooms"] != null
            ? List<int>.from(json["number_of_rooms"].map((x) => x))
            : [],
        numberOfBathrooms: json["number_of_bathrooms"] != null
            ? List<int>.from(json["number_of_bathrooms"].map((x) => x))
            : [],
        featuresIds: json["features_ids"] != null
            ? List<RealEstatesFeatures>.from(json["features_ids"]
                .map((x) => RealEstatesFeatures.fromJson(x)))
            : [],
        sortBy: json["sort_by"] != null
            ? List<RealEstateConstants>.from(
                json["sort_by"].map((x) => RealEstateConstants.fromJson(x)))
            : [],
        multiSelect: json["multi_select"] != null
            ? List<String>.from(json["multi_select"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "real_estate_status":
            List<dynamic>.from(realEstateStatus!.map((x) => x.toJson())),
        "type": List<dynamic>.from(type!.map((x) => x.toJson())),
        "transaction_type":
            List<dynamic>.from(transactionType!.map((x) => x.toJson())),
        "type_status": List<dynamic>.from(typeStatus!.map((x) => x.toJson())),
        // "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
        // "price": price.toJson(),
        "number_of_rooms": List<dynamic>.from(numberOfRooms!.map((x) => x)),
        "number_of_bathrooms":
            List<dynamic>.from(numberOfBathrooms!.map((x) => x)),
        // "features_ids": List<dynamic>.from(featuresIds.map((x) => x.toJson())),
        "sort_by": List<dynamic>.from(sortBy!.map((x) => x.toJson())),
        "multi_select": List<dynamic>.from(multiSelect!.map((x) => x)),
      };
}
