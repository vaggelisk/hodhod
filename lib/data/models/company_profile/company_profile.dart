import 'package:hodhod/data/models/languages/language.dart';

class CompanyProfile {
  int? id;
  String? uuid;
  String? name;
  String? logo;
  String? email;
  String? mobile;
  String? countryCode;
  String? countryIso;
  String? personalPageUrl;
  String? gender;
  String? genderKey;
  String? dateOfBirth;
  dynamic experienceYears;
  String? about;
  String? brokerNumberRegulatoryAuthority;
  String? brokerOrnNumber;
  String? brokerLicenseNumber;
  String? license;
  String? licenseExpiryDate;
  String? status;
  String? statusKey;
  String? createdAt;
  String? updatedAt;
  List<Language>? languages;

  CompanyProfile({
    this.id,
    this.uuid,
    this.name,
    this.logo,
    this.email,
    this.mobile,
    this.countryCode,
    this.countryIso,
    this.personalPageUrl,
    this.gender,
    this.genderKey,
    this.dateOfBirth,
    this.experienceYears,
    this.about,
    this.brokerNumberRegulatoryAuthority,
    this.brokerOrnNumber,
    this.brokerLicenseNumber,
    this.license,
    this.licenseExpiryDate,
    this.status,
    this.statusKey,
    this.createdAt,
    this.updatedAt,
    this.languages,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) => CompanyProfile(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        logo: json["logo"],
        email: json["email"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
        countryIso: json["country_iso"],
        personalPageUrl: json["personal_page_url"],
        gender: json["gender"],
        genderKey: json["gender_key"],
        dateOfBirth: json["date_of_birth"],
        experienceYears: json["experience_years"],
        about: json["about"],
        brokerNumberRegulatoryAuthority:
            json["broker_number_regulatory_authority"],
        brokerOrnNumber: json["broker_orn_number"],
        brokerLicenseNumber: json["broker_license_number"],
        license: json["license"],
        licenseExpiryDate: json["license_expiry_date"],
        status: json["status"],
        statusKey: json["status_key"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        languages: json["languages"] != null ? List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "logo": logo,
        "email": email,
        "mobile": mobile,
        "country_code": countryCode,
        "country_iso": countryIso,
        "personal_page_url": personalPageUrl,
        "gender": gender,
        "gender_key": genderKey,
        "date_of_birth": dateOfBirth,
        "experience_years": experienceYears,
        "about": about,
        "broker_number_regulatory_authority": brokerNumberRegulatoryAuthority,
        "broker_orn_number": brokerOrnNumber,
        "broker_license_number": brokerLicenseNumber,
        "license": license,
        "license_expiry_date": licenseExpiryDate,
        "status": status,
        "status_key": statusKey,
        "created_at": createdAt,
        "updated_at": updatedAt,
        // "languages": List<Language>.from(languages!.map((x) => x.toJson())),
      };
}
