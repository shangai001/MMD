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

@property (nonatomic, assign)id<GoseeLoanDetailDelegate> detailDelegate;

@end
