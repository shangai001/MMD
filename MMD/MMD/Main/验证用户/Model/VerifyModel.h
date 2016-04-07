//
//  VerifyModel.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface VerifyModel : BaseModel

/**
 *  完善基本信息第一步,传入输入的信息
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)postFirstInformation:(NSDictionary *)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler;
/**
 *  完善第二步信息,传入选择的数据
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)postSecondInformation:(NSDictionary *)info
                      success:(successHandler)successHandler
                      failure:(failureHandler)failureHandler;

/**
 *  获取选择器数据(categoryId代表不同的选择器)
 *
 *  @param categoryId
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)getPicerData:(NSInteger)categoryId success:(successHandler)successHandler
                   failure:(failureHandler)failureHandler;


@end
