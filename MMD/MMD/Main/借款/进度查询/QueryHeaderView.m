//
//  QueryHeaderView.m
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryHeaderView.h"
#import "ColorHeader.h"

@interface QueryHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *loanNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *loanTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *loanTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UILabel *loanTextLabel;

@end
@implementation QueryHeaderView

- (void)awakeFromNib{
}
- (IBAction)seeLoanDetail:(id)sender {
    
    if ([self.detailDelegate respondsToSelector:@selector(openLoanDetail:)]) {
        [self.detailDelegate openLoanDetail:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
