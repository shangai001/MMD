//
//  LogginHandler.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LogginHandler : NSObject

/**
 *  跳转到登录页面
 *
 *  @param currentVC
 */
+ (void)shouldLogginAt:(UIViewController *)currentVC;


@end
