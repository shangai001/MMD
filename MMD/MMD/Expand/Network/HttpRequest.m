//
//  HttpRequest.m
//  基于AFNetWorking的再封装
//
//  Created by Eric on 16/1/2.
//  Copyright © 2016年 wuhongxing. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking.h>
#import "UploadParam.h"
#import "AppInfo.h"


@implementation HttpRequest


#define TIME_OUT 10
#define REQUEST_MAXCOUNT 5

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json" ,nil];
    manager.operationQueue.maxConcurrentOperationCount = REQUEST_MAXCOUNT;
    manager.requestSerializer.timeoutInterval = TIME_OUT;
    NSString *versionURLString = [self appendVersionString:URLString];
    [manager GET:versionURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            [self noticeReturnCode:jsonObject];
            success(jsonObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
    
    //添加verison
    parameters = [self containVersionDictionary:parameters];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            [self noticeReturnCode:jsonObject];
            success(jsonObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST/GET网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
    
    switch (type) {
        case HttpRequestTypeGet:
        {
            
            //添加version
            NSString *versionURLString = [self appendVersionString:URLString];
            manager.requestSerializer.timeoutInterval = TIME_OUT;
            
            [manager GET:versionURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    [self noticeReturnCode:jsonObject];
                    success(jsonObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            //添加version
            parameters = [self containVersionDictionary:parameters];
            
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    [self noticeReturnCode:jsonObject];
                    success(jsonObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}

#pragma mark -- 上传图片 --
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(UploadParam *)uploadParam
                    success:(void (^)())success
                    failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //添加verison
    parameters = [self containVersionDictionary:parameters];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            [self noticeReturnCode:jsonObject];
            success(jsonObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)postUUIDWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg", nil];
    
    //添加verison
    parameters = [self containVersionDictionary:parameters];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success && [responseObject isKindOfClass:[NSData class]]) {
            id imageObject = [UIImage imageWithData:responseObject];
            success(imageObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
+ (void)downloadFile:(NSString *)fileUrl baseName:(NSString *)name success:(void (^)(id result))success failure:(void (^)(NSError * error))failure{
    
    //首先找到文件储存地址
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *result = [documents stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //删除原文件
    if ([fileManager fileExistsAtPath:result]) {
        NSLog(@"相同文件名已经存在");
        NSError *error = nil;
        if ([fileManager removeItemAtPath:result error:&error]) {
            NSLog(@"原文件删除成功");
        }else{
            NSLog(@"错误 %@",error);
        }
    }
    
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:fileUrl]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    policy.validatesDomainName = NO;
    policy.allowInvalidCertificates = NO;
    sessionManager.securityPolicy = policy;
    sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:urlRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:name];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            success(filePath);
        }else{
            failure(error);
        }
    }];
    [downloadTask resume];
}
//GET  方法 添加版本号
+ (NSString *)appendVersionString:(NSString *)URLString{
    
    NSString *mimidaiVersion = [AppInfo app_Version];
    NSString *URLString_Version = [NSString stringWithFormat:@"%@/%@",URLString,mimidaiVersion];
    
    return URLString_Version;
}
//POST 方法 添加版本号
+ (id)containVersionDictionary:(id)parameters{
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *infoDic = (NSDictionary *)parameters;
        NSMutableDictionary *versionDic = [NSMutableDictionary dictionaryWithDictionary:infoDic];
        NSString *mimidaiVersion = [AppInfo app_Version];
        [versionDic setObject:mimidaiVersion forKey:@"mimidaiVersion"];
        return versionDic;
    }
    return parameters;
}
//拦截 返回 code
+ (void)noticeReturnCode:(id)responseObject{
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultDic = (NSDictionary *)responseObject;
        NSInteger code = [resultDic[@"code"] integerValue];
        if (code  == 9) {
            [SDUserDefault setBool:NO forKey:Loggin];
        }
        NSAssert(code != 9, @"登录失效，请重新登录");
    }
}
@end
