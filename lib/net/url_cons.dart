// 定义所有接口请求url链接。。。
const baseUrl = "http://47.115.211.194";
const basePort = ':8000/';

/// 上传图片
const uploadImage = '$baseUrl${basePort}upload/images';
///登录接口
const appLogin = 'api/member/auth/get';
/// 获取用户信息
const userInfo = 'api/member/user/get';
/// 修改用户信息
const userInfoUpdate = 'api/member/user/update';
/// 获取考试成绩
const testResult = 'api/member/exam/get';
/// 修改密码
const resetPwd = 'api/member/auth/update';
/// 意见反馈
const feedback = 'api/member/feedback/create';
/// 公告列表
const notice = 'api/member/notice/get';
/// 课程类型列表
const lessonType = 'api/course/type/get';
/// 课程列表
const lessonList = 'api/course/item/get';
/// 学习地图
const studyMap = 'api/course/map/get';
/// 试卷获取
const testGet = 'api/course/paper/get';
/// 交卷
const testCreate = 'api/member/exam/create';
/// 知识库
const knowledgeList = 'api/course/tag/get';
/// 学习时长
const studyTime = 'api/member/course/create';
/// 学习排行榜
const studyTimeRank = 'api/member/course/get';
/// 通关排行榜
const studyMapRank = 'api/member/user/get';


