//
//  ContactsTableViewCell+PutContentInfo.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ContactsTableViewCell+PutContentInfo.h"
#import "ContactsItem.h"

@implementation ContactsTableViewCell (PutContentInfo)

- (void)putContentInfo:(ContactsItem *)item{
    
    self.nameLabel.text = item.name;
    self.relationlabel.text = item.relation;
    self.phoneLabel.text = item.phone;
}

@end
