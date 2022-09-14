import 'dart:convert';

import 'Language.dart';
List<LanguageModel> LangFromJson(String str) =>
    List<LanguageModel>.from(json.decode(str).map((x) => LanguageModel.fromJson(x)));
class LanguageModel {
  LanguageModel({
      this.language,});

  LanguageModel.fromJson(dynamic json) {
    if (json['language'] != null) {
      language = [];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v));
      });
    }
  }
  List<Language>? language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (language != null) {
      map['language'] = language!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}