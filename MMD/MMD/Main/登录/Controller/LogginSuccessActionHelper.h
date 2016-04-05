//
//  LogginSuccessActionHelper.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMLogViewController;

@interface LogginSuccessActionHelper : NSObject

+ (void)jumpFromViewController:(MMLogViewController *)logger userStatus:(NSInteger)status;

@end
