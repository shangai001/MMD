//
//  FailureView.m
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FailureView.h"

@implementation FailureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.codeTextField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshCode:)];
    [self.codeImage addGestureRecognizer:tap];
}
- (void)refreshCode:(id)sender{
    if ([self.delegate respondsToSelector:@selector(shouldRefreshCode)]) {
        [self.delegate shouldRefreshCode];
    }
}
- (void)willEndInput{
    if ([self.codeTextField isFirstResponder]) {
        [self.codeTextField resignFirstResponder];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSString *codeString = textField.text;
    if ([self.delegate respondsToSelector:@selector(didEndInputCode:)] && codeString.length > 0) {
        [self.delegate didEndInputCode:codeString];
    }
    return YES;
}

@end
