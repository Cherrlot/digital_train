import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/pk_list_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


PkListEntity $PkListEntityFromJson(Map<String, dynamic> json) {
  final PkListEntity pkListEntity = PkListEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    pkListEntity.iD = iD;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    pkListEntity.category = category;
  }
  final String? department = jsonConvert.convert<String>(json['department']);
  if (department != null) {
    pkListEntity.department = department;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    pkListEntity.nickname = nickname;
  }
  final int? scores = jsonConvert.convert<int>(json['scores']);
  if (scores != null) {
    pkListEntity.scores = scores;
  }
  return pkListEntity;
}

Map<String, dynamic> $PkListEntityToJson(PkListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['category'] = entity.category;
  data['department'] = entity.department;
  data['nickname'] = entity.nickname;
  data['scores'] = entity.scores;
  return data;
}

extension PkListEntityExtension on PkListEntity {
  PkListEntity copyWith({
    String? iD,
    String? category,
    String? department,
    String? nickname,
    int? scores,
  }) {
    return PkListEntity()
      ..iD = iD ?? this.iD
      ..category = category ?? this.category
      ..department = department ?? this.department
      ..nickname = nickname ?? this.nickname
      ..scores = scores ?? this.scores;
  }
}