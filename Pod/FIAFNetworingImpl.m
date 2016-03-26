//
//  FIAFNetworingProtocol.m
//  e-friends
//
//  Created by 杨鹏 on 16/3/26.
//  Copyright © 2016年 上海名扬科技股份有限公司. All rights reserved.
//

#import "FIAFNetworingImpl.h"
#import "FIAFNetworking.h"

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

@end
