//
//  FIAFNetworingProtocol.m
//  e-friends
//
//  Created by 杨鹏 on 16/3/26.
//  Copyright © 2016年 上海名扬科技股份有限公司. All rights reserved.
//

#import "FIAFNetworingImpl.h"

@implementation FIAFNetworingImpl
- (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type params:(NSDictionary *)params
{
    /*UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;
    NSString *stringName = [name stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    stringName = [stringName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [FIURLManager urlWithType:type];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    [mutableRequest setValue:[[UIDevice currentDevice] slm_uniqueDeviceIdentifier] forHTTPHeaderField:@"DEVICE_ID"];
    [mutableRequest setValue:@"PHONE" forHTTPHeaderField:@"DEVICE_TYPE"];
    [mutableRequest setValue:@"iOS" forHTTPHeaderField:@"OS"];
    [mutableRequest setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"OS_VERSION"];
    [mutableRequest setValue:@"APPID"forHTTPHeaderField:@"APP_ID"];
    [mutableRequest setValue:@"ACCESSTOKEN" forHTTPHeaderField:@"ACCESSTOKEN"];
    [mutableRequest setValue:@"FIAPPVersion" forHTTPHeaderField:@"APP_VERSION"];
    [mutableRequest setValue:stringName forHTTPHeaderField:@"DEVICE_NAME"];
    return mutableRequest;*/
    return nil;
}

- (void)ModifyHttpRequestHeader:(AFHTTPSessionManager *)sessionManager type:(FIHttpRequestType)type {
    /*UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;
    NSString *stringName = [name stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    stringName = [stringName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [sessionManager.requestSerializer setValue:[[UIDevice currentDevice] slm_uniqueDeviceIdentifier] forHTTPHeaderField:@"DEVICE_ID"];
    [sessionManager.requestSerializer setValue:@"PHONE" forHTTPHeaderField:@"DEVICE_TYPE"];
    [sessionManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"OS"];
    [sessionManager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"OS_VERSION"];
    [sessionManager.requestSerializer setValue:[[FIDataContext shareDataContext] appId] forHTTPHeaderField:@"APP_ID"];
    [sessionManager.requestSerializer setValue:[[FIDataContext shareDataContext] accessToken] forHTTPHeaderField:@"ACCESSTOKEN"];
    [sessionManager.requestSerializer setValue:FIAPPVersion forHTTPHeaderField:@"APP_VERSION"];
    [sessionManager.requestSerializer setValue:stringName forHTTPHeaderField:@"DEVICE_NAME"];
    
    NSLog(@"HTTP请求头:%@", sessionManager.requestSerializer.HTTPRequestHeaders);*/
}

- (void)ModifyHttpReponseHeader:(AFHTTPSessionManager *)sessionManager type:(FIHttpRequestType)type {
    /*if (FIHTTP_REQUEST_TYPE_VISITDOCOTRCARD_GET == type) {
        //获取网页格式 text/html
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    NSLog(@"Response响应:%@", sessionManager.responseSerializer.acceptableContentTypes);*/
}

- (NSString *)strURLWithType:(FIHttpRequestType)type {
    /*NSString *urlString = @"";
    NSDictionary *dicionyURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"api"];
    
    switch (type) {
            
        case FIHTTP_REQUEST_TYPE_ALLAPI_GET:  //返回所有的接口json数据
        {
            NSString *aString = @"http://121.43.231.51:6868/edoctor/init-config";
            NSString *append = [NSString stringWithFormat:@"?appId=%@&appVersion=%@",@"appid",@"appversion"];
            urlString = [NSString stringWithFormat:@"%@%@",aString,append];
        }
            break;
            
        case FIHTTP_REQUEST_TYPE_CONFIG_GET:
            urlString = [dicionyURL objectForKey:@"api_0000"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CHECKUPDATE_GET:
            urlString = [dicionyURL objectForKey:@"api_0001"];
            break;
            
        case FIHTTP_REQUEST_TYPE_QRSCAN_POST:
            urlString = [dicionyURL objectForKey:@"api_0002"];
            break;
            
        case FIHTTP_REQUEST_TYPE_LOGIN_POST:
            urlString = [dicionyURL objectForKey:@"api_0100"];
            break;
            
        case FIHTTP_REQUEST_TYPE_LOGOUT_GET:
            urlString = [dicionyURL objectForKey:@"api_0101"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SENDCODE_POST:
            urlString = [dicionyURL objectForKey:@"api_0102"];
            break;
            
        case FIHTTP_REQUEST_TYPE_VALIDATECODE_POST:
            urlString = [dicionyURL objectForKey:@"api_0103"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CREATEDOCTOR_POST:
            urlString = [dicionyURL objectForKey:@"api_0200"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CREATEPATIENT_POST:
            urlString = [dicionyURL objectForKey:@"api_0201"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SETPASSWORD_POST:
            urlString = [dicionyURL objectForKey:@"api_0202"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UPDATEDOCTORINFO_POST:
            urlString = [dicionyURL objectForKey:@"api_0203"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UPDATEPATIENTINFO_POST:
            urlString = [dicionyURL objectForKey:@"api_0204"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UPLOADAVATAR_POST:
            urlString = [dicionyURL objectForKey:@"api_0205"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SHOWDOCTORINFO_GET:
            urlString = [dicionyURL objectForKey:@"api_0206"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SHOWPATIENTINFO_GET:
            urlString = [dicionyURL objectForKey:@"api_0207"];
            break;
            
        case FIHTTP_REQUEST_TYPE_VISITDOCOTRCARD_GET:
            urlString = [dicionyURL objectForKey:@"api_0208"];
            break;
            
        case FIHTTP_REQUEST_TYPE_DOCTORBANKACCOUNT_POST:
            urlString = [dicionyURL objectForKey:@"api_0209"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UPDATEDOCTORBANKACCOUT_POST:
            urlString = [dicionyURL objectForKey:@"api_0210"];
            break;
            
        case FIHTTP_REQUEST_TYPE_BILLLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0211"];
            break;
            
        case FIHTTP_REQUEST_TYPE_DOCTORSHARECARD_GET:
            urlString = [dicionyURL objectForKey:@"api_0212"];
            break;
            
        case FIHTTP_REQUEST_TYPE_PATIENTSHARECARD_GET:
            urlString = [dicionyURL objectForKey:@"api_0213"];
            break;
            
        case FIHTTP_REQUEST_TYPE_ADDFRIENT_POST:
            urlString = [dicionyURL objectForKey:@"api_0214"];
            break;
            
        case FIHTTP_REQUEST_TYPE_ROOMLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0300"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SHOWROOMDETIAL_GET:
            urlString = [dicionyURL objectForKey:@"api_0301"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CREATEROOM_POST:
            urlString = [dicionyURL objectForKey:@"api_0302"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SETROOMNAME_POST:
            urlString = [dicionyURL objectForKey:@"api_0303"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SETROOMTOP_POST:
            urlString = [dicionyURL objectForKey:@"api_0304"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UNSETROOMTOP_POST:
            urlString = [dicionyURL objectForKey:@"api_0305"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SETROOMUNREAD_POST:
            urlString = [dicionyURL objectForKey:@"api_0306"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SETROOMSILENT_POST:
            urlString = [dicionyURL objectForKey:@"api_0307"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UNSETROOMSILENT_POST:
            urlString = [dicionyURL objectForKey:@"api_0308"];
            break;
            
        case FIHTTP_REQUEST_TYPE_HIDEROOM_POST:
            urlString = [dicionyURL objectForKey:@"api_0309"];
            break;
            
        case FIHTTP_REQUEST_TYPE_DISSOLVEROOM_POST:
            urlString = [dicionyURL objectForKey:@"api_0310"];
            break;
            
        case FIHTTP_REQUEST_TYPE_ADDMEMBERTOROOM_POST:
            urlString = [dicionyURL objectForKey:@"api_0311"];
            break;
            
        case FIHTTP_REQUEST_TYPE_DELMEMBERFROMROOM_POST:
            urlString = [dicionyURL objectForKey:@"api_0312"];
            break;
            
        case FIHTTP_REQUEST_TYPE_MSGLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0400"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UNREADMSGLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0401"];
            break;
            
        case FIHTTP_REQUEST_TYPE_STARTCONSULT_POST:
            urlString = [dicionyURL objectForKey:@"api_0402"];
            break;
            
        case FIHTTP_REQUEST_TYPE_REJESTCONSULT_POST:
            urlString = [dicionyURL objectForKey:@"api_0403"];
            break;
            
        case FIHTTP_REQUEST_TYPE_FINISHCONSULT_POST:
            urlString = [dicionyURL objectForKey:@"api_0404"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SENDTEXTMSG_POST:
            urlString = [dicionyURL objectForKey:@"api_0405"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SENDDISEASERECORDMSG_POST:
            urlString = [dicionyURL objectForKey:@"api_0406"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SENDIMAGEMSG_POST:
            urlString = [dicionyURL objectForKey:@"api_0407"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SENDVOICEMSG_POST:
            urlString = [dicionyURL objectForKey:@"api_0408"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SHOWCONSULTPLAN_GET:
            urlString = [dicionyURL objectForKey:@"api_0500"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CONSULTPLANLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0501"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CREATECONSULTPLAN_POST:
            urlString = [dicionyURL objectForKey:@"api_0502"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UPDATECONSULTPLAN_POST:
            urlString = [dicionyURL objectForKey:@"api_0503"];
            break;
            
        case FIHTTP_REQUEST_TYPE_DELCONSULTPLAN_POST:
            urlString = [dicionyURL objectForKey:@"api_0504"];
            break;
            
        case FIHTTP_REQUEST_TYPE_ROOMSELECTLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0505"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CONSUEORDER_POST:
            urlString = [dicionyURL objectForKey:@"api_0506"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CONSUELPAID_POST:
            urlString = [dicionyURL objectForKey:@"api_0507"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SHOWTRANSACTIONRECORD_GET:
            urlString = [dicionyURL objectForKey:@"api_0600"];
            break;
            
        case FIHTTP_REQUEST_TYPE_TRANSACTIONRECORDLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0601"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CREATETRANSACTIONRECORD_POST:
            urlString = [dicionyURL objectForKey:@"api_0602"];
            break;
            
        case FIHTTP_REQUEST_TYPE_DISEASERECORDLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_0800"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CREATEDISEASERECORD_POST:
            urlString = [dicionyURL objectForKey:@"api_0801"];
            break;
            
        case FIHTTP_REQUEST_TYPE_UPDATEDISEASERECORD_POST:
            urlString = [dicionyURL objectForKey:@"api_0802"];
            break;
            
        case FIHTTP_REQUEST_TYPE_SHOWDISEASERECORD_POST:
            urlString = [dicionyURL objectForKey:@"api_0803"];
            break;
            
        case FIHTTP_REQUEST_TYPE_HOSPITALDEPTLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_1600"];
            break;
            
        case FIHTTP_REQUEST_TYPE_HOSPITALLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_1601"];
            break;
            
        case FIHTTP_REQUEST_TYPE_PROVINCELIST_GET:
            urlString = [dicionyURL objectForKey:@"api_1602"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CITYLIST_GET:
            urlString = [dicionyURL objectForKey:@"api_1603"];
            break;
            
        case FIHTTP_REQUEST_TYPE_CONTACT_GET:
            urlString = [dicionyURL objectForKey:@"api_0209"];
            break;
            
        default:
            break;
    }
    
    return urlString;*/
    return nil;
}

@end
