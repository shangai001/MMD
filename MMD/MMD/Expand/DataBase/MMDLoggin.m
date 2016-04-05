//
//  MMDLoggin.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMDLoggin.h"

@implementation MMDLoggin

+ (BOOL)isLoggin{
    
    BOOL isLoggin = [SDUserDefault boolForKey:Loggin];
    
    return isLoggin;
}

@end
