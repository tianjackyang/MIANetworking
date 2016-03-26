//
//  FIURLManager.h
//  FICorpUMSApp
//

#import <Foundation/Foundation.h>

@interface FIURLManager : NSObject
+ (NSString *)strURLWithType:(FIHttpRequestType)type;
+ (NSURL *)urlWithType:(FIHttpRequestType)type;

@end
