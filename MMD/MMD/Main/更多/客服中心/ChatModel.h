//
//  ChatModel.h
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic) BOOL isGroupChat;

- (void)addSpecifiedItem:(NSDictionary *)dic;



@end
