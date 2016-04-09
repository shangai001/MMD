//
//  ZXMemberDetail.h
//  ZXSDK
//
//  Created by Ray on 16/4/1.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import "ZXBaseModel.h"
#import "ZXIDcardModel.h"
#import "ZXMemberModel.h"

@interface ZXMemberDetail : ZXBaseModel

@property NSString *uid;
@property ZXIDcardModel *idcardModel;
@property ZXMemberModel *memberModel;

@end
