class LocalText{
  String? ar;
  String? en;

  LocalText({
    this.ar,
    this.en,
  });

  factory LocalText.fromJson(Map<String, dynamic> json) => LocalText(
    ar: json["ar"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "ar": ar,
    "en": en,
  };
}