import 'package:hodhod/data/models/company_profile/company_profile.dart';

class User {
  int? id;
  dynamic uid;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? mobile;
  bool? mobileVerified;
  dynamic mobileVerifiedAt;
  String? countryCode;
  String? countryIso;
  String? image;
  bool? isActive;
  String? language;
  String? createdAt;
  String? updatedAt;
  int? notificationsCount;
  int? readNotificationsCount;
  int? unreadNotificationsCount;
  CompanyProfile? companyProfile;
  dynamic profile;

  User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobile,
    this.mobileVerified,
    this.mobileVerifiedAt,
    this.countryCode,
    this.countryIso,
    this.image,
    this.isActive,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.notificationsCount,
    this.readNotificationsCount,
    this.unreadNotificationsCount,
    this.companyProfile,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        mobile: json["mobile"],
        mobileVerified: json["mobile_verified"],
        mobileVerifiedAt: json["mobile_verified_at"],
        countryCode: json["country_code"],
        countryIso: json["country_iso"],
        image: json["image"],
        isActive: json["is_active"],
        language: json["language"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        notificationsCount: json["notifications_count"],
        readNotificationsCount: json["read_notifications_count"],
        unreadNotificationsCount: json["unread_notifications_count"],
        profile: json["profile"],
        companyProfile: json["company_profile"] != null
            ? CompanyProfile.fromJson(json["company_profile"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "mobile": mobile,
        "mobile_verified": mobileVerified,
        "mobile_verified_at": mobileVerifiedAt,
        "country_code": countryCode,
        "country_iso": countryIso,
        "image": image,
        "is_active": isActive,
        "language": language,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "notifications_count": notificationsCount,
        "read_notifications_count": readNotificationsCount,
        "unread_notifications_count": unreadNotificationsCount,
        "profile": profile,
        "company_profile": companyProfile,
      };
}
