class Language {
  Language({
      this.title, 
      this.imagePath, 
      this.country,});

  Language.fromJson(dynamic json) {
    title = json['Title'];
    imagePath = json['Image_path'];
    country = json['Country'];
  }
  String ?title;
  String ?imagePath;
  String ?country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = title;
    map['Image_path'] = imagePath;
    map['Country'] = country;
    return map;
  }

}