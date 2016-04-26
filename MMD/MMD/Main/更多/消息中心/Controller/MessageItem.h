//
//  MessageItem.h
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItem : NSObject

/**
 *  messageId
 */
@property (copy, nonatomic)NSString *mId;

@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *content;
@property (copy, nonatomic)NSString *type;
@property (copy, nonatomic)NSString *state;
@property (copy, nonatomic)NSString *sendTime;
@property (copy, nonatomic)NSString *sendResult;
@property (copy, nonatomic)NSString *category;

@end
