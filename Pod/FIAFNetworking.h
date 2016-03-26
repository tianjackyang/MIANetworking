//
//  FIAFNetworking.h
//  e-friends
//
//  Created by 杨鹏 on 16/3/26.
//  Copyright © 2016年 上海名扬科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FIHTTPEnum.h"

@protocol FIAFNetworking <NSObject>
//修改请求头
- (void)ModifyHttpRequestHeader:(AFHTTPSessionManager *)sessionManager type:(FIHttpRequestType)type;
//修改响应头
- (void)ModifyHttpReponseHeader:(AFHTTPSessionManager *)sessionManager type:(FIHttpRequestType)type;
//修改请求头
- (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type params:(NSDictionary *)params;
//自定义url
- (NSString *)strURLWithType:(FIHttpRequestType)type;
@end
