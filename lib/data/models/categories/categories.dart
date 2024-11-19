class Categories {
  int? id;
  String? name;
  String? description;
  String? image;
  dynamic categoryId;

  Categories({
    this.id,
    this.name,
    this.description,
    this.image,
    this.categoryId,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "category_id": categoryId,
      };
}
