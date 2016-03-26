//
//  FIURLManager.h
//  FICorpUMSApp
//

#import <Foundation/Foundation.h>
#import "FIHTTPEnum.h"

@interface FIURLManager : NSObject
+ (NSString *)strURLWithType:(FIHttpRequestType)type;
+ (NSURL *)urlWithType:(FIHttpRequestType)type;

@end
