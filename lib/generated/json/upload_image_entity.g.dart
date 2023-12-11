import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/upload_image_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


UploadImageEntity $UploadImageEntityFromJson(Map<String, dynamic> json) {
  final UploadImageEntity uploadImageEntity = UploadImageEntity();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    uploadImageEntity.url = url;
  }
  return uploadImageEntity;
}

Map<String, dynamic> $UploadImageEntityToJson(UploadImageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  return data;
}

extension UploadImageEntityExtension on UploadImageEntity {
  UploadImageEntity copyWith({
    String? url,
  }) {
    return UploadImageEntity()
      ..url = url ?? this.url;
  }
}