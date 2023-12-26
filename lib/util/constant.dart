import 'dart:ui';

class Constants {
  static const String token = 'token';
  static const String userName = 'userName';
  static const String nickName = 'nickName';
  static const String account = 'account';
  static const String headUrl = 'headUrl';
  static const String userDepart = 'userDepart';
  static const String userPhone = 'userPhone';
  /// 跳过的升级版本号
  static const String skipVersion = 'skipVersion';

  /// 考试判断题类型
  static const String typeJudge = 'truefalse';

  /// 考试单选题类型
  static const String typeRadio = 'radio';

  /// 考试多选题类型
  static const String typeCheck = 'checkbox';


  static const Color successBgColor = Color.fromRGBO(202, 237, 220, 1);
  static const Color successTextColor = Color.fromRGBO(6, 95, 70, 1);

  static const Color errorBgColor = Color.fromRGBO(254, 242, 242, 1);
  static const Color errorTextColor = Color.fromRGBO(156, 34, 34, 1);

  static const Color infoBgColor = Color.fromRGBO(239, 246, 255, 1);
  static const Color infoTextColor = Color.fromRGBO(88, 145, 255, 1);

  static const Color warnBgColor = Color.fromRGBO(255, 251, 235, 1);
  static const Color warnTextColor = Color.fromRGBO(180, 83, 9, 1);

  static const PAGE_SIZE = 20;
}
