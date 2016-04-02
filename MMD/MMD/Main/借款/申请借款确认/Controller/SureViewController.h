//
//  SureViewController.h
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@protocol AgreeLoanProtro <NSObject>

- (void)didAgreeLoanProto:(id)sender;


@end

@interface SureViewController : BaseViewController

@property (weak, nonatomic)id<AgreeLoanProtro> agreeDelegate;

@end
