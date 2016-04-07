//
//  ReadFiler.h
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadFiler : NSObject
/**
 *  解析文本
 *
 *  @param fileName
 *  @param type
 *
 *  @return
 */
+ (NSString *)readTextFile:(NSString *)fileName fileType:(NSString *)type;
/**
 *  解析字典文件
 *
 *  @param fileName
 *  @param type
 *
 *  @return
 */
+ (NSDictionary *)readDictionaryFile:(NSString *)fileName fileType:(NSString *)type;
/**
 *  解析数组文件
 *
 *  @param fileName
 *  @param type
 *
 *  @return 
 */
+ (NSArray *)readArrayFile:(NSString *)fileName fileType:(NSString *)type;


@end
