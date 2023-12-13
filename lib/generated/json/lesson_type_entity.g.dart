import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/lesson_type_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


LessonTypeEntity $LessonTypeEntityFromJson(Map<String, dynamic> json) {
  final LessonTypeEntity lessonTypeEntity = LessonTypeEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    lessonTypeEntity.iD = iD;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    lessonTypeEntity.name = name;
  }
  return lessonTypeEntity;
}

Map<String, dynamic> $LessonTypeEntityToJson(LessonTypeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['name'] = entity.name;
  return data;
}

extension LessonTypeEntityExtension on LessonTypeEntity {
  LessonTypeEntity copyWith({
    String? iD,
    String? name,
  }) {
    return LessonTypeEntity()
      ..iD = iD ?? this.iD
      ..name = name ?? this.name;
  }
}