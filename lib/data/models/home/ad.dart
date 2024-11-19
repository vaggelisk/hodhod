class Ad {
  int? id;
  String? title;
  String? description;
  String? image;
  dynamic userId;

  Ad({
    this.id,
    this.title,
    this.description,
    this.image,
    this.userId,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "user_id": userId,
      };
}
