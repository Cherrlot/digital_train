import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/lesson_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


LessonEntity $LessonEntityFromJson(Map<String, dynamic> json) {
  final LessonEntity lessonEntity = LessonEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    lessonEntity.iD = iD;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    lessonEntity.title = title;
  }
  final String? descr = jsonConvert.convert<String>(json['descr']);
  if (descr != null) {
    lessonEntity.descr = descr;
  }
  final String? teacher = jsonConvert.convert<String>(json['teacher']);
  if (teacher != null) {
    lessonEntity.teacher = teacher;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    lessonEntity.cover = cover;
  }
  final String? vedio = jsonConvert.convert<String>(json['vedio']);
  if (vedio != null) {
    lessonEntity.video = vedio;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    lessonEntity.duration = duration;
  }
  final String? typeId = jsonConvert.convert<String>(json['typeId']);
  if (typeId != null) {
    lessonEntity.typeId = typeId;
  }
  return lessonEntity;
}

Map<String, dynamic> $LessonEntityToJson(LessonEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['title'] = entity.title;
  data['descr'] = entity.descr;
  data['teacher'] = entity.teacher;
  data['cover'] = entity.cover;
  data['vedio'] = entity.video;
  data['duration'] = entity.duration;
  data['typeId'] = entity.typeId;
  return data;
}

extension LessonEntityExtension on LessonEntity {
  LessonEntity copyWith({
    String? iD,
    String? title,
    String? descr,
    String? teacher,
    String? cover,
    String? vedio,
    int? duration,
    String? typeId,
  }) {
    return LessonEntity()
      ..iD = iD ?? this.iD
      ..title = title ?? this.title
      ..descr = descr ?? this.descr
      ..teacher = teacher ?? this.teacher
      ..cover = cover ?? this.cover
      ..video = vedio ?? this.video
      ..duration = duration ?? this.duration
      ..typeId = typeId ?? this.typeId;
  }
}