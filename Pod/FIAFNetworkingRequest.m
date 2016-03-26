//
//  FIAFNetworkingRequest.m
//  FICorpUMSApp
//
//

/* 
[NSURLSession]
    |
    ---AFURLSessionManager
    ---AFHTTPSessionManager(继承自AFURLSessionManager)
 
[Serialization]
 
 -<AFURLRequestSerialization>
    |
    ---AFHTTPRequestSerializer
    ---AFJSONRequestSerializer
    ---AFPropertyListRequestSerializer
 
 -<AFURLResponseSerialization>
    |
    ---AFHTTPResponseSerializer
    ---AFJSONResponseSerializer
    ---AFXMLParserResponseSerializer
    ---AFXMLDocumentResponseSerializer (Mac OS X)
    ---AFPropertyListResponseSerializer
    ---AFImageResponseSerializer
    ---AFCompoundResponseSerializer

[Additional Functionality]
    |
    ---AFSecurityPolicy
    ---AFNetworkReachabilityManager
*/

/*
 * AFNetWorking3.0以后抛弃了NSURLConnect,全部采用NSURLSession
 *
 *1. 需要注意的是,默认提交请求的数据是AFHTTPRequestSerializer,返回格式是AFJSONResponseSerializer
 * 1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
 *
 *2. 请求格式
 * AFHTTPRequestSerializer            二进制格式
 * AFJSONRequestSerializer            JSON
 * AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 *
 *3. 返回格式
 * AFHTTPResponseSerializer           二进制格式
 * AFJSONResponseSerializer           JSON
 * AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
 * AFXMLDocumentResponseSerializer    (Mac OS X)
 * AFPropertyListResponseSerializer   PList
 * AFImageResponseSerializer          Image
 * AFCompoundResponseSerializer       组合
 *
 *4.安全和连接
 * AFSecurityPolicy                   设置安全属性
 * AFNetworkReachabilityManager       检测网络连接
*/

#import "FIAFNetworkingRequest.h"
#import "FIHttpRequestManager.h"

@interface FIAFNetworkingRequest ()


@end

@implementation FIAFNetworkingRequest

+ (void)ModifyHttpRequestHeader:(AFHTTPSessionManager *)sessionManager {
    UIDevice *device = [[UIDevice alloc] init];
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
    
    NSLog(@"HTTP请求头:%@", sessionManager.requestSerializer.HTTPRequestHeaders);
}

+ (void)ModifyHttpReponseHeader:(AFHTTPSessionManager *)sessionManager type:(FIHttpRequestType)type {
    if (FIHTTP_REQUEST_TYPE_VISITDOCOTRCARD_GET == type) {
        //获取网页格式 text/html
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    NSLog(@"Response响应:%@", sessionManager.responseSerializer.acceptableContentTypes);
}

/**
 *  Get 请求
 *
 *  @param type     FIHttpRequestType
 *  @param params   请求必须传入的参数
 *  @param progress 请求的进度block
 *  @param success  请求成功block
 *  @param failure  请求失败block
 */
+(void)httpGet:(FIHttpRequestType)type
        params:(NSDictionary *)params
      progress:(void(^)(id operation))progress
       success:(void(^)(id operation , id responseObject))success
       failure:(void (^)(id operation ,NSError *error))failure
{
 
    NSString *afUrl  = [FIURLManager strURLWithType:type];
    if (IsNilOrNull(afUrl)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            slm_alert(@"url地址为空！");
        });
    }
    
    
    if (IsNilOrNull(afUrl)) {
        return;
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [self ModifyHttpRequestHeader:sessionManager];
    [self ModifyHttpReponseHeader:sessionManager type:type];
    [sessionManager GET:afUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度:%@", downloadProgress);
        progress(downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回信息:%@", task.response);
        if (FIHTTP_REQUEST_TYPE_VISITDOCOTRCARD_GET == type) {
            NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"返回html:%@",result);
        }
        else {
            NSLog(@"成功:%@",responseObject);
        }
        success(task, responseObject);
        
        if ([responseObject[@"errcode"] longValue] == 4011) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[FIAppDelegate shareAppDelegate] switchToLoginViewController];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@", error);
        failure(task, error);
    }];
}

/**
 *  Post 请求
 *
 *  @param type     FIHttpRequestType
 *  @param params   请求必须传入的参数
 *  @param progress 请求的进度block
 *  @param success  请求成功block
 *  @param failure  请求失败block
 */
+(void)httpPost:(FIHttpRequestType)type
         params:(NSDictionary *)params
       progress:(void(^)(id operation))progress
        success:(void(^)(id operation , id responseObject))success
        failure:(void (^)(id operation, NSError *error))failure
{

    // 获取url string 格式的地址；
    NSString *afUrl  = [FIURLManager strURLWithType:type];
    if (IsNilOrNull(afUrl)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            slm_alert(@"url地址为空！");
        });
    }
    
    if (IsNilOrNull(afUrl)) {
        return;
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [self ModifyHttpRequestHeader:sessionManager];
    [self ModifyHttpReponseHeader:sessionManager type:type];
    [sessionManager POST:afUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度:%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回信息:%@", task.response);
        NSLog(@"成功:%@",responseObject);
        success(task, responseObject);
        
        if ([responseObject[@"errcode"] longValue] == 4011) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[FIAppDelegate shareAppDelegate] switchToLoginViewController];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@", error);
        failure(task, error);
    }];
}

/**
 *  Post 请求
 *
 *  @param type     FIHttpRequestType
 *  @param params   请求必须传入的参数
 *  @param filepath 文件路径
 *  @param data     数据
 *  @param name     文件类型名（file,image）
 *  @param filename 文件名（xx.jpeg,xx.png）
 *  @param mimeType mime类型（image/jpeg）
 *  @param body     修改消息体
 *  @param progress 请求的进度block
 *  @param success  请求成功block
 *  @param failure  请求失败block
 */
+(void)httpPost:(FIHttpRequestType)type
         params:(NSDictionary *)params
       filePath:(NSURL*)filepath
     uploadData:(NSData*)data
           name:(NSString*)name
       fileName:(NSString*)filename
       mimeType:(NSString*)mimeType
  constructBody:(void (^)(id <AFMultipartFormData> formData))body
       progress:(void(^)(id operation))progress
        success:(void(^)(id operation , id responseObject))success
        failure:(void (^)(id operation, NSError *error))failure
{
    // 获取url string 格式的地址；
    NSString *afUrl  = [FIURLManager strURLWithType:type];
    if (IsNilOrNull(afUrl)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            slm_alert(@"url地址为空！");
        });
    }
    
    if (IsNilOrNull(afUrl)) {
        return;
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [self ModifyHttpRequestHeader:sessionManager];
    [self ModifyHttpReponseHeader:sessionManager type:type];
    [sessionManager POST:afUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:filename mimeType:mimeType];
        NSLog(@"消息体:%@", formData);
        body(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度:%@", uploadProgress);
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回信息:%@", task.response);
        NSLog(@"成功:%@",responseObject);
        success(task, responseObject);
        
        if ([responseObject[@"errcode"] longValue] == 4011) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[FIAppDelegate shareAppDelegate] switchToLoginViewController];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@", error);
        failure(task, error);
    }];
}

/**
 *  下载数据
 *
 *  @param type     FIHttpRequestType
 *  @param params   请求必须传入的参数
 *  @param progress 请求的进度block
 *  @param filepath 下载完成后保存的文件路径
 *  @param failure  请求失败block
 */
+(void)httpDownload:(FIHttpRequestType)type params:(NSDictionary *)params
           savePath:(NSURL*)filepath
           progress:(void (^)(NSProgress *downloadProgress)) progress
           success:(void (^)(id operation, NSURL *filePath , NSString* filename)) success
            failure:(void (^)(id operation, NSError *error))failure{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *managerDownload = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [FIHttpRequestManager requestWithType:type
                                                           params:params];
    NSURLSessionDownloadTask *downloadTask = [managerDownload downloadTaskWithRequest:request
                                                                             progress:^(NSProgress *downloadProgress) {
                                                                                 progress(downloadProgress);
                                                                             }
                                                                          destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
           return  [filepath URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSString *filename = [response suggestedFilename];
        NSLog(@"File downloaded to: %@", filePath);
        
        if (error) {
            
            NSLog(@" 下载失败 ；");
            failure(response,error);
            
        }else{
            
            NSLog(@" 下载成功 ；");
            success(response,filePath ,filename);
            
        }
        
    }];
    
    [downloadTask resume];
}

/**
 *  上传文档
 *
 *  @param type     FIHttpRequestType
 *  @param params   请求必须传入的参数
 *  @param fileURL  上传的文件的路径
 *  @param progress 请求的进度block
 *  @param success  PASS
 *  @param failure  FAIL
 */
+(void)httpUpload:(FIHttpRequestType)type
           params:(NSDictionary *)params
         filePath:(NSURL*)filepath
         progress:(void (^)(NSProgress *progress)) progress
          success:(void (^)(id operation, id dic))success
          failure:(void (^)(id operation, NSError *error))failure
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [FIHttpRequestManager requestWithType:type
                                                           params:params];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request
                                                               fromFile:filepath
                                                               progress:^(NSProgress *uploadProgress) {
                                                                   progress(uploadProgress);
                                                               }
                                                      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
       NSLog(@"%@  File downloaded", filepath);
        if (error) {
            NSLog(@"Error: %@", error);
            failure(response, error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
            success(response, responseObject);
        }
    }];
    
    [uploadTask resume];
}

/**
 *  上传文件
 *
 *  @param type     FIHttpRequestType
 *  @param params   请求必须传入的参数
 *  @param fileURL  上传的文件的路径
 *  @param filetype 上传的文件的类型（file,image）
 *  @param filename 上传的文件的名字 (**.png)
 *  @param mimeType 上传的文件的mime(image/jpeg)
 *  @param progress 请求的进度block
 *  @param success  PASS
 *  @param failure  FAIL
 */
+(void)httpUploadByMultiPart:(FIHttpRequestType)type
                      params:(NSDictionary*)params
                    fileURL:(NSURL*)fileurl
                    fileType:(NSString*)filetype
                    fileName:(NSString*)filename
                    mimeType:(NSString *)mimeType
                    progress:(void (^)(NSProgress *progress)) progress
                     success:(void (^)(id operation, id dic))success
                     failure:(void (^)(id operation, NSError *error))failure
{
    NSString *afUrl  = [FIURLManager strURLWithType:type];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:afUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileurl name:filetype fileName:filename mimeType:mimeType error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      progress(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          success(response, responseObject);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          failure(responseObject, error);
                      }
                  }];
    
    [uploadTask resume];
}

@end