class Pages {
  int? id;
  String? key;
  String? name;
  String? content;

  Pages({
    this.id,
    this.key,
    this.name,
    this.content,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "name": name,
        "content": content,
      };
}
