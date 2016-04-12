//
//  ZXBaseModel.h
//  ZXSDK
//
//  Created by Ray on 16/2/12.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import <Foundation/Foundation.h>


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

