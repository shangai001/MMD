//
//  ReadFiler.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ReadFiler.h"

@implementation ReadFiler

+ (NSString *)readTextFile:(NSString *)fileName fileType:(NSString *)type{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSError *readFileError = nil;
    NSString *parserString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&readFileError];
    NSAssert2(!readFileError, @"解析文本%@.%@出错", fileName, type);
    return parserString;
}
+ (NSDictionary *)readDictionaryFile:(NSString *)fileName fileType:(NSString *)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *mmdData = [NSData dataWithContentsOfFile:path];
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:mmdData options:NSJSONReadingAllowFragments error:nil];
    return object;
}
+ (NSArray *)readArrayFile:(NSString *)fileName fileType:(NSString *)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *mmdData = [NSData dataWithContentsOfFile:path];

    NSArray *object = [NSJSONSerialization JSONObjectWithData:mmdData options:NSJSONReadingAllowFragments error:nil];
    return object;
}
+ (id)readCalss:(id)calssInfo File:(NSString *)fileName fileType:(NSString *)type{
    
    if ([calssInfo isKindOfClass:[NSDictionary class]]) {
        return [self readDictionaryFile:fileName fileType:type];
    }else if ([calssInfo isKindOfClass:[NSArray class]]){
        return [self readArrayFile:fileName fileType:type];
    }else if ([calssInfo isKindOfClass:[NSString class]]){
        return [self readTextFile:fileName fileType:type];
    }
    return nil;
}
@end
