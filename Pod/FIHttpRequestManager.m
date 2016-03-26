//
//  FIHttpManage.m
//  FICorpUMSApp
//

#import "FIHttpRequestManager.h"
#import "FIQueryStringPair.h"

static NSString * const FIMultipartFormBoundary = @"Boundary+0xAbCdEfGbOuNdArY";
static FIHttpRequestManager *defaultManager = nil;

@implementation FIHttpRequestManager

#pragma mark -
#pragma mark  修改 app url 访问  增加访问头信息
+ (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type
{
    UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;
    NSString *stringName = [name stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    stringName = [stringName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [FIURLManager urlWithType:type];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    [mutableRequest setValue:[[UIDevice currentDevice] slm_uniqueDeviceIdentifier] forHTTPHeaderField:@"DEVICE_ID"];
    [mutableRequest setValue:@"PHONE" forHTTPHeaderField:@"DEVICE_TYPE"];
    [mutableRequest setValue:@"iOS" forHTTPHeaderField:@"OS"];
    [mutableRequest setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"OS_VERSION"];
    [mutableRequest setValue:[[FIDataContext shareDataContext] appId] forHTTPHeaderField:@"APP_ID"];
    [mutableRequest setValue:[[FIDataContext shareDataContext] accessToken] forHTTPHeaderField:@"ACCESSTOKEN"];
    [mutableRequest setValue:FIAPPVersion forHTTPHeaderField:@"APP_VERSION"];
    [mutableRequest setValue:stringName forHTTPHeaderField:@"DEVICE_NAME"];
    
    return mutableRequest;
}

+ (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type params:(NSDictionary *)params
{
    NSMutableURLRequest *request = [FIHttpRequestManager requestWithType:type];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self postDataWithParameters:params]];
    return request;
}

+ (NSMutableURLRequest *)requestWithType:(FIHttpRequestType)type params:(NSDictionary *)params file:(NSData *)data fileName:(NSString *)fileName
{
    NSMutableData *body = [NSMutableData data];
    NSMutableURLRequest *request = [FIHttpRequestManager requestWithType:type];
    
    //content type
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", FIMultipartFormBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSArray *allKeys = [params allKeys];
    int i;
    for (i = 0; i < [allKeys count]; i++)
    {
        NSString *key = [allKeys objectAtIndex:i];
        NSString *value = [params objectForKey:key];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@", FIMultipartFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\nContent-Disposition:form-data; name=\"%@\"", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\nContent-Type: text/plain; charset=US-ASCII" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\nContent-Transfer-Encoding: 8bit" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n\r\n%@", value] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", FIMultipartFormBoundary]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", @"file", fileName]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type:multipart/form-data\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@", FIMultipartFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    return request;
}

+ (NSData *)postDataWithParameters:(id)params
{
    NSString *jsonString = FIQueryStringFromParametersWithEncoding(params, NSUTF8StringEncoding);
    return [jsonString dataUsingEncoding:NSUTF8StringEncoding];
}


+ (FIHttpRequestManager *)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc] init];
    });
    return defaultManager;
}

@end
