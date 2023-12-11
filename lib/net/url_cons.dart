// 定义所有接口请求url链接。。。
// const baseUrl = "http://192.168.0.87:8080/";
const baseUrl = "http://47.115.211.194";
// const baseUrl = "http://47.115.211.194:7000/";
const basePort = ':8000/';
// const uploadPort = ':9003/';

const serviceUrl = {
  ///登录接口
  // 'app_login': 'login/',
  'app_login': 'api/member/auth/get',
  // 'app_login': 'api/web/login/houseOperateApp',

  ///获取设备列表
  'machines': 'api/bas-machines',

  /// 获取用户信息
  'user_info': 'api/member/user/get',

  /// 获取考试成绩
  'test_result': 'api/test/result/get',

  /// 上传图片
  'upload_image': '$baseUrl${basePort}upload/images',
};