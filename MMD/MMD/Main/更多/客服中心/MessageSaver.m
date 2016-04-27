//
//  MessageSaver.m
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MessageSaver.h"

@implementation MessageSaver


+ (NSString *)filePath{
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    basePath = [basePath stringByAppendingPathComponent:@"messages_"];
    return basePath;
}
+ (NSMutableDictionary *)messageListWithUser:(NSString *)userId{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self filePath];
    NSString *userIdFile = [NSString stringWithFormat:@"%@.data",userId];
    path = [path stringByAppendingString:userIdFile];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSMutableDictionary *messageDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSString *savedUserId = messageDic[@"userId"];
        if ([userId isEqualToString:savedUserId]) {
            return messageDic;
        }
    }
    return nil;
}
/*
+ (NSDictionary *)messageList{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self filePath];
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *messageDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        return messageDic;
    }
    return nil;
}
 + (BOOL)saveMessages:(NSDictionary *)messageDic{
 
 NSString *filePath = [self filePath];
 BOOL success = [NSKeyedArchiver archiveRootObject:messageDic toFile:filePath];
 return success;
 }
 */
+ (BOOL)saveMessages:(NSDictionary *)messageDic user:(NSString *)userId{
    
    NSString *filePath = [self filePath];
    NSString *userIdFile = [NSString stringWithFormat:@"%@.data",userId];
    filePath = [filePath stringByAppendingString:userIdFile];
    
    NSMutableDictionary *toArchDic = [NSMutableDictionary dictionaryWithDictionary:messageDic];
    [toArchDic setObject:userId forKey:@"userId"];
    BOOL success = [NSKeyedArchiver archiveRootObject:toArchDic toFile:filePath];
    return success;
}

@end
