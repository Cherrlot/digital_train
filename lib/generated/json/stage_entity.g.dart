import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/stage_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';

import 'package:digital_train/model/lesson_entity.dart';


StageEntity $StageEntityFromJson(Map<String, dynamic> json) {
  final StageEntity stageEntity = StageEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    stageEntity.iD = iD;
  }
  final String? learnMapId = jsonConvert.convert<String>(json['learnMapId']);
  if (learnMapId != null) {
    stageEntity.learnMapId = learnMapId;
  }
  final String? courseId = jsonConvert.convert<String>(json['courseId']);
  if (courseId != null) {
    stageEntity.courseId = courseId;
  }
  final LessonEntity? course = jsonConvert.convert<LessonEntity>(json['course']);
  if (course != null) {
    stageEntity.course = course;
  }
  return stageEntity;
}

Map<String, dynamic> $StageEntityToJson(StageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['learnMapId'] = entity.learnMapId;
  data['courseId'] = entity.courseId;
  data['course'] = entity.course.toJson();
  return data;
}

extension StageEntityExtension on StageEntity {
  StageEntity copyWith({
    String? iD,
    String? learnMapId,
    String? courseId,
    LessonEntity? course,
  }) {
    return StageEntity()
      ..iD = iD ?? this.iD
      ..learnMapId = learnMapId ?? this.learnMapId
      ..courseId = courseId ?? this.courseId
      ..course = course ?? this.course;
  }
}