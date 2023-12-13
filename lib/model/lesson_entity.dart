import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/lesson_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/lesson_entity.g.dart';

@JsonSerializable()
class LessonEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String title;
  late String descr;
  late String teacher;
  late String cover;
  late String vedio;
  late int duration;
  late String typeId;

  @override
  LessonEntity fromJson(Map<String, dynamic> json) {
    return LessonEntity.fromJson(json);
  }

  LessonEntity(
      {String? iD,
      String? title,
      String? descr,
      String? teacher,
      String? cover,
      String? vedio,
      int? duration,
      String? typeId})
      : iD = iD ?? '',
        title = iD ?? '',
        descr = descr ?? '',
        teacher = teacher ?? '',
        cover = cover ?? '',
        vedio = vedio ?? '',
        duration = duration ?? 0,
        typeId = typeId ?? '';

  factory LessonEntity.fromJson(Map<String, dynamic> json) => $LessonEntityFromJson(json);

  Map<String, dynamic> toJson() => $LessonEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
