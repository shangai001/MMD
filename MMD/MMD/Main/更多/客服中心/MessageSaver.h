//
//  MessageSaver.h
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageSaver : NSObject

/**
 *  获取聊天记录
 *
 *  @param messageDic
 *
 *  @return
 */
+ (NSMutableDictionary *)messageListWithUser:(NSString *)userId;
/**
 *  保存聊天记录
 *
 *  @param messageDic 聊天记录
 *
 *  @return 
 */
+ (BOOL)saveMessages:(NSDictionary *)messageDic user:(NSString *)userId;

@end
