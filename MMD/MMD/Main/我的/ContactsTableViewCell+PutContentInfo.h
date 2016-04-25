//
//  ContactsTableViewCell+PutContentInfo.h
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ContactsTableViewCell.h"

@class ContactsItem;

@interface ContactsTableViewCell (PutContentInfo)

- (void)putContentInfo:(ContactsItem *)item;

@end
