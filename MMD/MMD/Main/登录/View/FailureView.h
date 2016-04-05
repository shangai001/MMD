//
//  FailureView.h
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol didEndInputCode <NSObject>

- (void)didEndInputCode:(NSString *)codeString;
- (void)shouldRefreshCode;

@end
@interface FailureView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *codeIcomImage;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic)id<didEndInputCode> delegate;


- (void)willEndInput;

@end
