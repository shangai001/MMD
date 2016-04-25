//
//  ContactsTableViewCell.h
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationlabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
