import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/lesson_type_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/lesson_type_entity.g.dart';

@JsonSerializable()
class LessonTypeEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String name;

  factory LessonTypeEntity.fromJson(Map<String, dynamic> json) => $LessonTypeEntityFromJson(json);

  Map<String, dynamic> toJson() => $LessonTypeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  @override
  LessonTypeEntity fromJson(Map<String, dynamic> json) {
    return LessonTypeEntity.fromJson(json);
  }

  LessonTypeEntity({String? iD, String? name})
      : iD = iD ?? '',
        name = name ?? '';
}
