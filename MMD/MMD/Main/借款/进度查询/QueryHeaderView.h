//
//  QueryHeaderView.h
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoseeLoanDetailDelegate <NSObject>

@optional

- (void)openLoanDetail:(id)sender;

@end

@interface QueryHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *loanNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *loanTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *loanTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UILabel *loanTextLabel;
@property (nonatomic, assign)id<GoseeLoanDetailDelegate> detailDelegate;

@end
