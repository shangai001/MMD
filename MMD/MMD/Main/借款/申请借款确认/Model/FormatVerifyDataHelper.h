//
//  FormatVerifyDataHelper.h
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FormatVerifyDataHelper : NSObject

/**
 *  返回item数组
 *
 *  @param item 
 *
 *  @return
 */
+ (NSMutableArray *)ez_itemsArrayForVerifymoney:(NSInteger)loanMoney time:(NSInteger)moth;

/**
 *  返回最底部还款信息
 *
 *  @param item
 *
 *  @return 
 */
+ (NSMutableArray *)ez_bottomItemArrayForBottomCellmoney:(NSInteger)loanMoney time:(NSInteger)moth;



@end
