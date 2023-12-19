import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/knowledge_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


KnowledgeEntity $KnowledgeEntityFromJson(Map<String, dynamic> json) {
  final KnowledgeEntity knowledgeEntity = KnowledgeEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    knowledgeEntity.iD = iD;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    knowledgeEntity.name = name;
  }
  final List<KnowledgeArticles>? articles = (json['articles'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<KnowledgeArticles>(e) as KnowledgeArticles).toList();
  if (articles != null) {
    knowledgeEntity.articles = articles;
  }
  return knowledgeEntity;
}

Map<String, dynamic> $KnowledgeEntityToJson(KnowledgeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['name'] = entity.name;
  data['articles'] = entity.articles.map((v) => v.toJson()).toList();
  return data;
}

extension KnowledgeEntityExtension on KnowledgeEntity {
  KnowledgeEntity copyWith({
    String? iD,
    String? name,
    List<KnowledgeArticles>? articles,
  }) {
    return KnowledgeEntity()
      ..iD = iD ?? this.iD
      ..name = name ?? this.name
      ..articles = articles ?? this.articles;
  }
}

KnowledgeArticles $KnowledgeArticlesFromJson(Map<String, dynamic> json) {
  final KnowledgeArticles knowledgeArticles = KnowledgeArticles();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    knowledgeArticles.iD = iD;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    knowledgeArticles.title = title;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    knowledgeArticles.content = content;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    knowledgeArticles.author = author;
  }
  final String? createDate = jsonConvert.convert<String>(json['createDate']);
  if (createDate != null) {
    knowledgeArticles.createDate = createDate;
  }
  final String? updateDate = jsonConvert.convert<String>(json['updateDate']);
  if (updateDate != null) {
    knowledgeArticles.updateDate = updateDate;
  }
  return knowledgeArticles;
}

Map<String, dynamic> $KnowledgeArticlesToJson(KnowledgeArticles entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['title'] = entity.title;
  data['content'] = entity.content;
  data['author'] = entity.author;
  data['createDate'] = entity.createDate;
  data['updateDate'] = entity.updateDate;
  return data;
}

extension KnowledgeArticlesExtension on KnowledgeArticles {
  KnowledgeArticles copyWith({
    String? iD,
    String? title,
    String? content,
    String? author,
    String? createDate,
    String? updateDate,
  }) {
    return KnowledgeArticles()
      ..iD = iD ?? this.iD
      ..title = title ?? this.title
      ..content = content ?? this.content
      ..author = author ?? this.author
      ..createDate = createDate ?? this.createDate
      ..updateDate = updateDate ?? this.updateDate;
  }
}