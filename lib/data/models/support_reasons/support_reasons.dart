class SupportReasons {
  int? id;
  String? content;

  SupportReasons({
    this.id,
    this.content,
  });

  factory SupportReasons.fromJson(Map<String, dynamic> json) => SupportReasons(
        id: json["id"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
      };
}
