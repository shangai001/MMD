//
//  BaseModel.h
//  ZXRZB
//
//  Created by Ray on 16/2/12.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import "Foundation/Foundation.h"


@interface ZXBaseModel : NSObject


-(void)initProperty;
-(id)initWithDictionary:(NSDictionary *)data;

-(NSString *)PK;
-(id)fromDictionary:(NSDictionary *)data;
-(NSDictionary *)toDictionary;

-(BOOL)saveToLocal;
-(BOOL)readFromLocal;
-(BOOL)deleteFromLocal;

//+(NSString *)md5:(NSString *)str;

@end

