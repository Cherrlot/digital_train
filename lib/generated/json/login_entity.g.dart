import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/login_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    loginEntity.token = token;
  }
  final String? authId = jsonConvert.convert<String>(json['authId']);
  if (authId != null) {
    loginEntity.authId = authId;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['authId'] = entity.authId;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    String? token,
    String? authId,
  }) {
    return LoginEntity()
      ..token = token ?? this.token
      ..authId = authId ?? this.authId;
  }
}