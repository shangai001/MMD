//
//  ZXBaseModel.h
//  ZXSDK
//
//  Created by Ray on 16/2/12.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

/**
 * 获得图片的回调函数
 * @param image ：正确返回的图片 (当error存在的时候返回nil)
 * @param error : 如果图片获取不到，返回的错误 (当image存在的时候返回nil)
 */
typedef void(^ZXImageHandler)(UIImage *image,NSError *error);

@interface ZXBaseModel : NSObject


-(void)initProperty;
-(id)initWithDataDictionary:(NSDictionary *)data;

-(NSString *)PK;
-(id)fromDictionary:(NSDictionary *)data;
-(NSDictionary *)toDictionary;

-(BOOL)saveToLocal;
-(BOOL)readFromLocal;
-(BOOL)deleteFromLocal;

@end

