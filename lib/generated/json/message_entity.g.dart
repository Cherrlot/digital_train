import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/message_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


MessageEntity $MessageEntityFromJson(Map<String, dynamic> json) {
  final MessageEntity messageEntity = MessageEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    messageEntity.iD = iD;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    messageEntity.title = title;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    messageEntity.type = type;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    messageEntity.content = content;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    messageEntity.image = image;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    messageEntity.status = status;
  }
  return messageEntity;
}

Map<String, dynamic> $MessageEntityToJson(MessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['content'] = entity.content;
  data['image'] = entity.image;
  data['status'] = entity.status;
  return data;
}

extension MessageEntityExtension on MessageEntity {
  MessageEntity copyWith({
    String? iD,
    String? title,
    int? type,
    String? content,
    String? image,
    int? status,
  }) {
    return MessageEntity()
      ..iD = iD ?? this.iD
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..content = content ?? this.content
      ..image = image ?? this.image
      ..status = status ?? this.status;
  }
}