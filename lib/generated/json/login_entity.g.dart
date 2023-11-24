import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final String? accessToken = jsonConvert.convert<String>(json['accessToken']);
  if (accessToken != null) {
    loginEntity.accessToken = accessToken;
  }
  final int? accessExpire = jsonConvert.convert<int>(json['accessExpire']);
  if (accessExpire != null) {
    loginEntity.accessExpire = accessExpire;
  }
  final int? refreshAfter = jsonConvert.convert<int>(json['refreshAfter']);
  if (refreshAfter != null) {
    loginEntity.refreshAfter = refreshAfter;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['accessToken'] = entity.accessToken;
  data['accessExpire'] = entity.accessExpire;
  data['refreshAfter'] = entity.refreshAfter;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    String? accessToken,
    int? accessExpire,
    int? refreshAfter,
  }) {
    return LoginEntity()
      ..accessToken = accessToken ?? this.accessToken
      ..accessExpire = accessExpire ?? this.accessExpire
      ..refreshAfter = refreshAfter ?? this.refreshAfter;
  }
}