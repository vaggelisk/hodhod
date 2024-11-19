import 'real_estate_constants.dart';

class RealEstateConstantsData {
  List<RealEstateConstants>? realEstateCompleteStatus;
  List<RealEstateConstants>? realEstateActionType;
  List<RealEstateConstants>? realEstateTransactionType;
  List<RealEstateConstants>? realEstateStatusManagement;
  List<RealEstateConstants>? realEstateAvailableStatus;

  RealEstateConstantsData({
    this.realEstateCompleteStatus,
    this.realEstateActionType,
    this.realEstateTransactionType,
    this.realEstateStatusManagement,
    this.realEstateAvailableStatus,
  });

  factory RealEstateConstantsData.fromJson(Map<String, dynamic> json) =>
      RealEstateConstantsData(
        realEstateCompleteStatus: json["REAL_ESTATE_COMPLETE_STATUS"] != null
            ? List<RealEstateConstants>.from(json["REAL_ESTATE_COMPLETE_STATUS"]
                .map((x) => RealEstateConstants.fromJson(x)))
            : [],
        realEstateActionType: json["REAL_ESTATE_ACTION_TYPE"] != null
            ? List<RealEstateConstants>.from(json["REAL_ESTATE_ACTION_TYPE"]
                .map((x) => RealEstateConstants.fromJson(x)))
            : [],
        realEstateTransactionType: json["REAL_ESTATE_TRANSACTION_TYPE"] != null
            ? List<RealEstateConstants>.from(
                json["REAL_ESTATE_TRANSACTION_TYPE"]
                    .map((x) => RealEstateConstants.fromJson(x)))
            : [],
        realEstateStatusManagement:
            json["REAL_ESTATE_STATUS_MANAGEMENT"] != null
                ? List<RealEstateConstants>.from(
                    json["REAL_ESTATE_STATUS_MANAGEMENT"]
                        .map((x) => RealEstateConstants.fromJson(x)))
                : [],
        realEstateAvailableStatus: json["REAL_ESTATE_AVAILABLE_STATUS"] != null
            ? List<RealEstateConstants>.from(
                json["REAL_ESTATE_AVAILABLE_STATUS"]
                    .map((x) => RealEstateConstants.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "REAL_ESTATE_COMPLETE_STATUS": List<dynamic>.from(
            realEstateCompleteStatus!.map((x) => x.toJson())),
        "REAL_ESTATE_ACTION_TYPE":
            List<dynamic>.from(realEstateActionType!.map((x) => x.toJson())),
        "REAL_ESTATE_TRANSACTION_TYPE": List<dynamic>.from(
            realEstateTransactionType!.map((x) => x.toJson())),
        "REAL_ESTATE_STATUS_MANAGEMENT": List<dynamic>.from(
            realEstateStatusManagement!.map((x) => x.toJson())),
        "REAL_ESTATE_AVAILABLE_STATUS": List<dynamic>.from(
            realEstateAvailableStatus!.map((x) => x.toJson())),
      };
}
