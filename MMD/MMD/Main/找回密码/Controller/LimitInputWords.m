//
//  LimitInputWords.m
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LimitInputWords.h"


//#define MAX_STARWORDS_LENGTH 20

@implementation LimitInputWords

+ (void)limitInputText:(UITextField *)textField textCount:(NSUInteger)count{
    
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > count)
            {
                textField.text = [toBeString substringToIndex:count];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > count)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:count];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:count];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, count)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }

}

@end
