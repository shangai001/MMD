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

@property NSString *uid;                     //uid

@property int recommend_index;               //推荐指数，-1：不可信，建议拒绝 0：未研判 1：部分可信，需要人工审核 2：基本可信 3：高度可信
@property NSString *recommend_remark;        //对推荐指数进行说明

@property ZXIDcardModel *idcardModel;
@property ZXMemberModel *memberModel;

@end
