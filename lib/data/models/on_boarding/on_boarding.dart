class OnBoarding{
  int? id;
  String? title;
  String? content;
  String? image;

  OnBoarding({
    this.id,
    this.title,
    this.content,
    this.image,
  });

  factory OnBoarding.fromJson(Map<String, dynamic> json) => OnBoarding(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image": image,
  };
}