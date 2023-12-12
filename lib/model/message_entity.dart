import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/message_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/message_entity.g.dart';

@JsonSerializable()
class MessageEntity extends BaseNetModel {
  @JSONField(name: "ID")
  String? iD;
  String? title;
  int? type;
  String? content;
  String? image;
  int? status;

  MessageEntity();

  @override
  MessageEntity fromJson(Map<String, dynamic> json) {
    return MessageEntity.fromJson(json);
  }

  factory MessageEntity.fromJson(Map<String, dynamic> json) => $MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => $MessageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
