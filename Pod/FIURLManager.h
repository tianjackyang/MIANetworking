//
//  FIURLManager.h
//  FICorpUMSApp
//

#import <Foundation/Foundation.h>
#import "FIDataContext.h"

@interface FIURLManager : NSObject
+ (NSString *)strURLWithType:(FIHttpRequestType)type;
+ (NSURL *)urlWithType:(FIHttpRequestType)type;

@end
