import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/stage_entity.g.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'dart:convert';

import 'package:digital_train/model/lesson_entity.dart';
export 'package:digital_train/generated/json/stage_entity.g.dart';

@JsonSerializable()
class StageEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String learnMapId;
  late String courseId;
  late LessonEntity course;

  @override
  StageEntity fromJson(Map<String, dynamic> json) {
    return StageEntity.fromJson(json);
  }

  StageEntity({String? iD, String? learnMapId, String? courseId, LessonEntity? course})
      : iD = iD ?? '',
        learnMapId = learnMapId ?? '',
        courseId = courseId ?? '',
        course = course ?? LessonEntity();

  factory StageEntity.fromJson(Map<String, dynamic> json) => $StageEntityFromJson(json);

  Map<String, dynamic> toJson() => $StageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
