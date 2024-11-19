class GlobalModel {
  bool? status;
  String? message;

  GlobalModel({
    this.status,
    this.message,
  });

  factory GlobalModel.fromJson(Map<String, dynamic> json) => GlobalModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        // "errors": errors?.toJson(),
      };
}
