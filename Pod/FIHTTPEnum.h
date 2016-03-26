//
//  FIHTTPMacro.h
//  e-friends
//
//

#ifndef FIHTTPMacro_h
#define FIHTTPMacro_h

typedef NS_ENUM(NSInteger, FIHttpRequestType) {
    FIHTTP_REQUEST_TYPE_ALLAPI_GET = 0,//所有API
    FIHTTP_REQUEST_TYPE_CONFIG_GET,//获取配置
    FIHTTP_REQUEST_TYPE_CHECKUPDATE_GET,//检查更新
    FIHTTP_REQUEST_TYPE_QRSCAN_POST,//扫描二维码
    FIHTTP_REQUEST_TYPE_LOGIN_POST,//用户登录
    FIHTTP_REQUEST_TYPE_LOGOUT_GET,//用户注销
    FIHTTP_REQUEST_TYPE_SENDCODE_POST,//发送手机验证码
    FIHTTP_REQUEST_TYPE_VALIDATECODE_POST,//验证手机验证码
    FIHTTP_REQUEST_TYPE_CREATEDOCTOR_POST,//创建医生用户
    FIHTTP_REQUEST_TYPE_CREATEPATIENT_POST,//创建病人用户
    FIHTTP_REQUEST_TYPE_SETPASSWORD_POST,//设置密码
    FIHTTP_REQUEST_TYPE_UPDATEDOCTORINFO_POST,//更新医生信息
    FIHTTP_REQUEST_TYPE_UPDATEPATIENTINFO_POST,//更新病患信息
    FIHTTP_REQUEST_TYPE_UPLOADAVATAR_POST,//上传头像
    FIHTTP_REQUEST_TYPE_SHOWDOCTORINFO_GET,//查看医生信息
    FIHTTP_REQUEST_TYPE_SHOWPATIENTINFO_GET,//查看病患信息
    FIHTTP_REQUEST_TYPE_VISITDOCOTRCARD_GET,//医生名片
    FIHTTP_REQUEST_TYPE_DOCTORBANKACCOUNT_POST,//设置医生收款账号
    FIHTTP_REQUEST_TYPE_UPDATEDOCTORBANKACCOUT_POST,//更新医生收款账号
    FIHTTP_REQUEST_TYPE_BILLLIST_GET,//患者每月账单
    FIHTTP_REQUEST_TYPE_DOCTORSHARECARD_GET, //医生分享名片
    FIHTTP_REQUEST_TYPE_PATIENTSHARECARD_GET, //病人分享名片
    FIHTTP_REQUEST_TYPE_ADDFRIENT_POST, //创建好友
    FIHTTP_REQUEST_TYPE_ROOMLIST_GET,//聊天室列表
    FIHTTP_REQUEST_TYPE_SHOWROOMDETIAL_GET,//聊天室详情
    FIHTTP_REQUEST_TYPE_CREATEROOM_POST,//创建聊天室
    FIHTTP_REQUEST_TYPE_SETROOMNAME_POST,//设置聊天室名称
    FIHTTP_REQUEST_TYPE_SETROOMTOP_POST,//设置聊天室置顶
    FIHTTP_REQUEST_TYPE_UNSETROOMTOP_POST,//取消聊天室置顶
    FIHTTP_REQUEST_TYPE_SETROOMUNREAD_POST,//设置聊天室未读数
    FIHTTP_REQUEST_TYPE_SETROOMSILENT_POST,//设置聊天室静音
    FIHTTP_REQUEST_TYPE_UNSETROOMSILENT_POST,//取消聊天室静音
    FIHTTP_REQUEST_TYPE_HIDEROOM_POST,//隐藏聊天室
    FIHTTP_REQUEST_TYPE_DISSOLVEROOM_POST,//解散聊天室
    FIHTTP_REQUEST_TYPE_ADDMEMBERTOROOM_POST,//添加聊天室成员
    FIHTTP_REQUEST_TYPE_DELMEMBERFROMROOM_POST,//删除聊天室成员
    FIHTTP_REQUEST_TYPE_MSGLIST_GET,//消息列表
    FIHTTP_REQUEST_TYPE_UNREADMSGLIST_GET,//未读消息列表
    FIHTTP_REQUEST_TYPE_STARTCONSULT_POST,//发起咨询
    FIHTTP_REQUEST_TYPE_REJESTCONSULT_POST,//拒绝咨询
    FIHTTP_REQUEST_TYPE_FINISHCONSULT_POST,//结束咨询
    FIHTTP_REQUEST_TYPE_SENDTEXTMSG_POST,//发送文本
    FIHTTP_REQUEST_TYPE_SENDDISEASERECORDMSG_POST,//发送病历
    FIHTTP_REQUEST_TYPE_SENDIMAGEMSG_POST,//发送图片
    FIHTTP_REQUEST_TYPE_SENDVOICEMSG_POST,//发送语音
    FIHTTP_REQUEST_TYPE_SHOWCONSULTPLAN_GET,//查看咨询号计划
    FIHTTP_REQUEST_TYPE_CONSULTPLANLIST_GET,//咨询号计划列表
    FIHTTP_REQUEST_TYPE_CREATECONSULTPLAN_POST,//创建咨询号计划
    FIHTTP_REQUEST_TYPE_UPDATECONSULTPLAN_POST,//更新咨询号计划
    FIHTTP_REQUEST_TYPE_DELCONSULTPLAN_POST,//删除咨询号计划
    FIHTTP_REQUEST_TYPE_ROOMSELECTLIST_GET,//聊天室咨询号选择列表
    FIHTTP_REQUEST_TYPE_CONSUEORDER_POST,//创建咨询号订单
    FIHTTP_REQUEST_TYPE_CONSUELPAID_POST,//付款
    FIHTTP_REQUEST_TYPE_SHOWTRANSACTIONRECORD_GET,//查看交易记录
    FIHTTP_REQUEST_TYPE_TRANSACTIONRECORDLIST_GET,//交易记录列表
    FIHTTP_REQUEST_TYPE_CREATETRANSACTIONRECORD_POST,//创建交易记录
    FIHTTP_REQUEST_TYPE_DISEASERECORDLIST_GET,//病历列表
    FIHTTP_REQUEST_TYPE_CREATEDISEASERECORD_POST,//创建病历
    FIHTTP_REQUEST_TYPE_UPDATEDISEASERECORD_POST,//更新病历
    FIHTTP_REQUEST_TYPE_SHOWDISEASERECORD_POST,//查看病历
    FIHTTP_REQUEST_TYPE_HOSPITALDEPTLIST_GET,//科室列表
    FIHTTP_REQUEST_TYPE_HOSPITALLIST_GET,//医院列表
    FIHTTP_REQUEST_TYPE_PROVINCELIST_GET,//省份列表
    FIHTTP_REQUEST_TYPE_CITYLIST_GET, //城市列表
    FIHTTP_REQUEST_TYPE_CONTACT_GET
};

#endif /* FIHTTPMacro_h */
