//
//  MMTabbar.m
//  MMD
//
//  Created by pencho on 16/2/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMTabbar.h"

@implementation MMTabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImage *)loanOnImage{
    if (!_loanOnImage) {
        _loanOnImage = [UIImage imageNamed:@"借款"];
    }
    return _loanOnImage;
}
- (UIImage *)loanOffImage{
    if (!_loanOffImage) {
        _loanOffImage = [UIImage imageNamed:@"借款0"];
    }
    return _loanOffImage;
}
- (UIImage *)reOnImage{
    if (!_reOnImage) {
        _reOnImage = [UIImage imageNamed:@"还款"];
    }
    return _reOnImage;
}
- (UIImage *)reOffImage{
    if (!_reOffImage) {
        _reOffImage = [UIImage imageNamed:@"还款0"];
    }
    return _reOffImage;
}
- (UIImage *)mineOnImage{
    if (!_mineOnImage) {
        _mineOnImage = [UIImage imageNamed:@"mine_on"];
    }
    return _mineOnImage;
}
- (UIImage *)mineOffImage{
    if (!_mineOffImage) {
        _mineOffImage = [UIImage imageNamed:@"mine_off"];
    }
    return _mineOffImage;
}
- (UIImage *)moreOnImage{
    if (!_moreOnImage) {
        _moreOnImage = [UIImage imageNamed:@"更多"];
    }
    return _moreOnImage;
}
- (UIImage *)moreOffImage{
    if (!_moreOffImage) {
        _moreOffImage = [UIImage imageNamed:@"更多0"];
    }
    return _moreOffImage;
}


@end
