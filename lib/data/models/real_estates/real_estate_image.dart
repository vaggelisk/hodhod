class RealEstateImage{
  int? id;
  String? image;

  RealEstateImage({
    this.id,
    this.image,
  });

  factory RealEstateImage.fromJson(Map<String, dynamic> json) => RealEstateImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}