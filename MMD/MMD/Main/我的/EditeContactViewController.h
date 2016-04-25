//
//  EditeContactViewController.h
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
@class ContactsItem;

@interface EditeContactViewController : BaseViewController

@property (strong,nonatomic)ContactsItem *item;
/**
 *  是否添加联系人
 */
@property (assign, nonatomic)BOOL isAdding;

@end
