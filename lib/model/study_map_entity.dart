import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/study_map_entity.g.dart';
import 'dart:convert';

import 'package:digital_train/model/stage_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/study_map_entity.g.dart';

@JsonSerializable()
class StudyMapEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String position;

  /// 当前用户学习阶段， 从1开始
  late int level;
  late bool isCurrent;
  late List<StageEntity> stages;

  @override
  StudyMapEntity fromJson(Map<String, dynamic> json) {
    return StudyMapEntity.fromJson(json);
  }

  StudyMapEntity({String? iD, String? position, int? level, bool? isCurrent, List<StageEntity>? stages})
      : iD = iD ?? '',
        position = position ?? '',
        level = level ?? 1,
        isCurrent = isCurrent ?? false,
        stages = stages ?? [];

  factory StudyMapEntity.fromJson(Map<String, dynamic> json) => $StudyMapEntityFromJson(json);

  Map<String, dynamic> toJson() => $StudyMapEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
