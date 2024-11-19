import 'package:hodhod/data/models/categories/categories.dart';
import 'package:hodhod/data/models/cities/cities.dart';
import 'package:hodhod/data/models/countries/countries.dart';
import 'package:hodhod/data/models/countries/currency.dart';
import 'package:hodhod/data/models/real_estates_features/real_estates_features_children.dart';
import 'package:hodhod/data/models/real_estates_types/real_estates_types.dart';
import 'package:hodhod/data/models/user/user.dart';

import 'local_text.dart';
import 'real_estate_image.dart';

class RealEstates {
  int? id;
  String? uid;
  String? title;
  LocalText? titleLocal;
  String? description;
  LocalText? descriptionLocal;
  String? mobile;
  String? countryCode;
  String? countryIso;
  dynamic price;
  String? address;
  dynamic latitude;
  dynamic longitude;
  String? permitNumber;
  dynamic numberOfRooms;
  dynamic numberOfBathrooms;
  dynamic numberOfFloors;
  String? image;
  String? realEstateStatus;
  String? realEstateStatusKey;
  String? type;
  String? typeKey;
  String? transactionType;
  String? transactionTypeKey;
  String? status;
  String? statusKey;
  String? typeStatus;
  String? typeStatusKey;
  String? createdAt;
  String? updatedAt;

  // ActionButtons actionButtons;
  String? createdAtDiff;
  String? deletedAtDiff;
  String? updatedAtDiff;
  dynamic featuresCount;
  dynamic imagesCount;
  dynamic userId;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic realEstateTypeId;
  dynamic currencyId;
  dynamic countryId;
  dynamic cityId;
  dynamic regionId;
  List<RealEstateImage>? images;
  Categories? category;
  Cities? city;
  Countries? country;
  Currency? currency;
  List<RealEstatesFeaturesChildren>? features;
  RealEstatesTypes? realEstateType;
  Categories? subCategory;
  User? user;
  bool? isFavorite;
  dynamic space;
  dynamic viewsCount;
  dynamic callsCount;
  dynamic whatsappCount;
  dynamic emailCount;
  bool? finance;

  RealEstates(
      {this.id,
      this.uid,
      this.title,
      this.titleLocal,
      this.description,
      this.descriptionLocal,
      this.mobile,
      this.countryCode,
      this.countryIso,
      this.price,
      this.address,
      this.latitude,
      this.longitude,
      this.permitNumber,
      this.numberOfRooms,
      this.numberOfBathrooms,
      this.numberOfFloors,
      this.image,
      this.realEstateStatus,
      this.realEstateStatusKey,
      this.type,
      this.typeKey,
      this.transactionType,
      this.transactionTypeKey,
      this.status,
      this.statusKey,
      this.typeStatus,
      this.typeStatusKey,
      this.createdAt,
      this.updatedAt,
      // this.actionButtons,
      this.createdAtDiff,
      this.deletedAtDiff,
      this.updatedAtDiff,
      this.featuresCount,
      this.imagesCount,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.realEstateTypeId,
      this.currencyId,
      this.countryId,
      this.cityId,
      this.regionId,
      this.images,
      this.category,
      this.city,
      this.country,
      this.currency,
      this.features,
      this.realEstateType,
      this.subCategory,
      this.user,
      this.isFavorite,
      this.space,
      this.viewsCount,
      this.callsCount,
      this.whatsappCount,
      this.emailCount,
      this.finance});

  factory RealEstates.fromJson(Map<String, dynamic> json) => RealEstates(
      id: json["id"],
      uid: json["uid"],
      title: json["title"],
      titleLocal: LocalText.fromJson(json["title_local"]),
      description: json["description"],
      descriptionLocal: LocalText.fromJson(json["description_local"]),
      mobile: json["mobile"],
      countryCode: json["country_code"],
      countryIso: json["country_iso"],
      price: json["price"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      permitNumber: json["permit_number"],
      numberOfRooms: json["number_of_rooms"],
      numberOfBathrooms: json["number_of_bathrooms"],
      numberOfFloors: json["number_of_floors"],
      image: json["image"],
      realEstateStatus: json["real_estate_status"],
      realEstateStatusKey: json["real_estate_status_key"],
      type: json["type"],
      typeKey: json["type_key"],
      transactionType: json["transaction_type"],
      transactionTypeKey: json["transaction_type_key"],
      status: json["status"],
      statusKey: json["status_key"],
      typeStatusKey: json["type_status_key"],
      typeStatus: json["type_status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      // actionButtons: ActionButtons.fromJson(json["action_buttons"]),
      createdAtDiff: json["created_at_diff"],
      deletedAtDiff: json["deleted_at_diff"],
      updatedAtDiff: json["updated_at_diff"],
      featuresCount: json["features_count"],
      imagesCount: json["images_count"],
      userId: json["user_id"],
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      realEstateTypeId: json["real_estate_type_id"],
      currencyId: json["currency_id"],
      countryId: json["country_id"],
      cityId: json["city_id"],
      regionId: json["region_id"],
      images: json["images"] != null
          ? List<RealEstateImage>.from(
              json["images"].map((x) => RealEstateImage.fromJson(x)))
          : [],
      category: json["category"] != null
          ? Categories.fromJson(json["category"])
          : null,
      city: json["city"] != null ? Cities.fromJson(json["city"]) : null,
      country:
          json["country"] != null ? Countries.fromJson(json["country"]) : null,
      currency:
          json["currency"] != null ? Currency.fromJson(json["currency"]) : null,
      features: json["features"] != null
          ? List<RealEstatesFeaturesChildren>.from(json["features"]
              .map((x) => RealEstatesFeaturesChildren.fromJson(x)))
          : [],
      realEstateType: json["realEstateType"] != null
          ? RealEstatesTypes.fromJson(json["realEstateType"])
          : null,
      subCategory: json["subCategory"] != null
          ? Categories.fromJson(json["subCategory"])
          : null,
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      isFavorite: json["is_favorite"],
      space: json["space"],
      viewsCount: json["views_count"],
      callsCount: json["calls_count"],
      whatsappCount: json["whatsapp_count"],
      emailCount: json["email_count"],
      finance: json["finance"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "title": title,
        "title_local": titleLocal?.toJson(),
        "description": description,
        "description_local": descriptionLocal?.toJson(),
        "mobile": mobile,
        "country_code": countryCode,
        "country_iso": countryIso,
        "price": price,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "permit_number": permitNumber,
        "number_of_rooms": numberOfRooms,
        "number_of_bathrooms": numberOfBathrooms,
        "number_of_floors": numberOfBathrooms,
        "image": image,
        "real_estate_status": realEstateStatus,
        "real_estate_status_key": realEstateStatusKey,
        "type": type,
        "type_key": typeKey,
        "transaction_type": transactionType,
        "transaction_type_key": transactionTypeKey,
        "status": status,
        "status_key": statusKey,
        "type_status": typeStatus,
        "type_status_key": typeStatusKey,
        "created_at": createdAt,
        "updated_at": updatedAt,
        // "action_buttons": actionButtons.toJson(),
        "created_at_diff": createdAtDiff,
        "deleted_at_diff": deletedAtDiff,
        "updated_at_diff": updatedAtDiff,
        "features_count": featuresCount,
        "images_count": imagesCount,
        "user_id": userId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "real_estate_type_id": realEstateTypeId,
        "currency_id": currencyId,
        "country_id": countryId,
        "city_id": cityId,
        "region_id": regionId,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "category": category?.toJson(),
        "city": city?.toJson(),
        "country": country?.toJson(),
        "currency": currency?.toJson(),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "realEstateType": realEstateType?.toJson(),
        "subCategory": subCategory?.toJson(),
        "user": user?.toJson(),
        "is_favorite": isFavorite,
        "space": space,
        "views_count": viewsCount,
        "calls_count": callsCount,
        "whatsapp_count": whatsappCount,
        "email_count": emailCount,
        "finance": finance,
      };
}
