import 'package:hodhod/data/models/categories/categories.dart';
import 'package:hodhod/data/models/home/ad.dart';
import 'package:hodhod/data/models/real_estates/real_estates.dart';

class HomeData {
  List<Ad>? ads;
  List<Categories>? categories;
  List<RealEstates>? realEstatesMostRequested;
  List<RealEstates>? realEstatesMostViewed;
  List<RealEstates>? realEstatesFinancing;
  int? unreadNotificationsCount;

  HomeData({
    this.ads,
    this.categories,
    this.realEstatesMostRequested,
    this.realEstatesMostViewed,
    this.realEstatesFinancing,
    this.unreadNotificationsCount,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        ads: json["ads"] != null
            ? List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x)))
            : [],
        categories: json["categories"] != null
            ? List<Categories>.from(
                json["categories"].map((x) => Categories.fromJson(x)))
            : [],
        realEstatesMostRequested: json["realEstatesMostRequested"] != null
            ? List<RealEstates>.from(json["realEstatesMostRequested"]
                .map((x) => RealEstates.fromJson(x)))
            : [],
        realEstatesMostViewed: json["realEstatesMostViewed"] != null
            ? List<RealEstates>.from(json["realEstatesMostViewed"]
                .map((x) => RealEstates.fromJson(x)))
            : [],
        realEstatesFinancing: json["realEstatesFinancing"] != null
            ? List<RealEstates>.from(json["realEstatesFinancing"]
                .map((x) => RealEstates.fromJson(x)))
            : [],
        unreadNotificationsCount: json["unread_notifications_count"],
      );

  Map<String, dynamic> toJson() => {
        "ads": List<dynamic>.from(ads!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "realEstatesMostRequested": List<dynamic>.from(
            realEstatesMostRequested!.map((x) => x.toJson())),
        "realEstatesMostViewed":
            List<dynamic>.from(realEstatesMostViewed!.map((x) => x.toJson())),
        "realEstatesFinancing":
            List<dynamic>.from(realEstatesFinancing!.map((x) => x.toJson())),
        "unread_notifications_count": unreadNotificationsCount,
      };
}
