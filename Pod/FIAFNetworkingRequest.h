//
//  FIAFNetworkingRequest.h
//  FICorpUMSApp
//
#import <Foundation/Foundation.h>
#import "FIAFNetworingImpl.h"

@interface FIAFNetworkingRequest : NSObject

@property (nonatomic, strong) id<FIAFNetworking> delegate;

+(FIAFNetworkingRequest*)shareAFNetworking;

//get 请求返回进度；
-(void)httpGet:(FIHttpRequestType)type
        params:(NSDictionary *)params
      progress:(void(^)(id operation))progress
      success:(void(^)(id operation , id responseObject))success
       failure:(void (^)(id operation ,NSError *error))failure;


//post 请求；
-(void)httpPost:(FIHttpRequestType)type
         params:(NSDictionary *)params
       progress:(void(^)(id operation))progress
        success:(void(^)(id operation , id responseObject))success
        failure:(void (^)(id operation, NSError *error))failure;

//post 请求同时修改请求Body；
-(void)httpPost:(FIHttpRequestType)type
         params:(NSDictionary *)params
       filePath:(NSURL*)filepath
     uploadData:(NSData*)data
           name:(NSString*)name
       fileName:(NSString*)filename
       mimeType:(NSString*)mimeType
  constructBody:(void (^)(id <AFMultipartFormData> formData))body
       progress:(void(^)(id operation))progress
        success:(void(^)(id operation , id responseObject))success
        failure:(void (^)(id operation, NSError *error))failure;

 
//download 下载请求；
-(void)httpDownload:(FIHttpRequestType)type params:(NSDictionary *)params
           savePath:(NSURL*)filepath
           progress:(void (^)(NSProgress *downloadProgress)) progress
           success:(void (^)(id operation, NSURL *filePath , NSString* filename)) success
            failure:(void (^)(id operation, NSError *error))failure;


//upload 上传请求；
-(void)httpUpload:(FIHttpRequestType)type
           params:(NSDictionary *)params
         filePath:(NSURL*)fileURL
       progress:(void (^)(NSProgress *downloadProgress)) progress
         success:(void (^)(id operation, id dic))response
          failure:(void (^)(id operation, NSError *error))failure;

//upload multi-part
-(void)httpUploadByMultiPart:(FIHttpRequestType)type
                      params:(NSDictionary*)params
                     fileURL:(NSURL*)fileurl
                    fileType:(NSString*)filetype
                    fileName:(NSString*)filename
                    mimeType:(NSString *)mimeType
                    progress:(void (^)(NSProgress *progress)) progress
                     success:(void (^)(id operation, id dic))success
                     failure:(void (^)(id operation, NSError *error))failure;

@end
