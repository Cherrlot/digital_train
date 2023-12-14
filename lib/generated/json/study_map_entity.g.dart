import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/study_map_entity.dart';
import 'package:digital_train/model/stage_entity.dart';

import 'package:flutter_nb_net/flutter_net.dart';


StudyMapEntity $StudyMapEntityFromJson(Map<String, dynamic> json) {
  final StudyMapEntity studyMapEntity = StudyMapEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    studyMapEntity.iD = iD;
  }
  final String? position = jsonConvert.convert<String>(json['position']);
  if (position != null) {
    studyMapEntity.position = position;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    studyMapEntity.level = level;
  }
  final bool? isCurrent = jsonConvert.convert<bool>(json['isCurrent']);
  if (isCurrent != null) {
    studyMapEntity.isCurrent = isCurrent;
  }
  final List<StageEntity>? stages = (json['stages'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<StageEntity>(e) as StageEntity).toList();
  if (stages != null) {
    studyMapEntity.stages = stages;
  }
  return studyMapEntity;
}

Map<String, dynamic> $StudyMapEntityToJson(StudyMapEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['position'] = entity.position;
  data['level'] = entity.level;
  data['isCurrent'] = entity.isCurrent;
  data['stages'] = entity.stages.map((v) => v.toJson()).toList();
  return data;
}

extension StudyMapEntityExtension on StudyMapEntity {
  StudyMapEntity copyWith({
    String? iD,
    String? position,
    int? level,
    bool? isCurrent,
    List<StageEntity>? stages,
  }) {
    return StudyMapEntity()
      ..iD = iD ?? this.iD
      ..position = position ?? this.position
      ..level = level ?? this.level
      ..isCurrent = isCurrent ?? this.isCurrent
      ..stages = stages ?? this.stages;
  }
}