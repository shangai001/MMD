//
//  MoreCellActionHelper.h
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MoreViewController;

@interface MoreCellActionHelper : NSObject

+ (void)jumpFromViewController:(MoreViewController *)originalController
                       atIndex:(NSIndexPath *)indexPath;

@end
