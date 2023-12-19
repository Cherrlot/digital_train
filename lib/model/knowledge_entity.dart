import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/knowledge_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/knowledge_entity.g.dart';

@JsonSerializable()
class KnowledgeEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String name;
  late List<KnowledgeArticles> articles;

  KnowledgeEntity({String? iD, String? name, List<KnowledgeArticles>? articles})
      : iD = iD ?? '',
        name = name ?? '',
        articles = articles ?? [];

  @override
  KnowledgeEntity fromJson(Map<String, dynamic> json) {
    return KnowledgeEntity.fromJson(json);
  }

  factory KnowledgeEntity.fromJson(Map<String, dynamic> json) => $KnowledgeEntityFromJson(json);

  Map<String, dynamic> toJson() => $KnowledgeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class KnowledgeArticles extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String title;
  late String content;
  late String author;
  late String createDate;
  late String updateDate;

  KnowledgeArticles(
      {String? iD, String? title, String? content, String? author, String? createDate, String? updateDate})
      : iD = iD ?? '',
        title = title ?? '',
        content = content ?? '',
        author = author ?? '',
        createDate = createDate ?? '',
        updateDate = updateDate ?? '';

  @override
  KnowledgeArticles fromJson(Map<String, dynamic> json) {
    return KnowledgeArticles.fromJson(json);
  }

  factory KnowledgeArticles.fromJson(Map<String, dynamic> json) => $KnowledgeArticlesFromJson(json);

  Map<String, dynamic> toJson() => $KnowledgeArticlesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
