//
//  HeaderView.h
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

- (void)didSelectButton:(UIButton *)button buttonIndex:(NSUInteger)index;

@end

@interface HeaderView : UIView


@property (weak, nonatomic) IBOutlet UIButton *askLoanButton;
@property (weak, nonatomic) IBOutlet UIButton *promotionButton;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonArray;
@property (assign, nonatomic)NSUInteger selectedIndex;
@property (weak, nonatomic)id<HeaderViewDelegate> headerDelegate;

@end
