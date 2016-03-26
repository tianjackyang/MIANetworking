//
//  FIHttpManage.h
//  FICorpUMSApp
//

#import <Foundation/Foundation.h>

@interface FIHttpRequestManager : NSObject

// 增加 修改 url  头文件；
+ (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type params:(NSDictionary *)params;
+ (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type params:(NSDictionary *)params file:(NSData *)data fileName:(NSString *)fileName;
+ (FIHttpRequestManager *)defaultManager;


@end
