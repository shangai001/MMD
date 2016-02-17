//
//  LoanViewController.m
//  MMD
//
//  Created by pencho on 16/2/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanViewController.h"
#import "MMSegmentControl.h"

@interface LoanViewController ()
@property (nonatomic ,strong)MMSegmentControl *segment;

@end

@implementation LoanViewController
#pragma LazyLoad
- (MMSegmentControl *)segment{
    if (!_segment) {
        NSArray *items = @[];
        _segment = [[MMSegmentControl alloc] initWithItems:items];
        _segment.selectedSegmentIndex = 0;
    }
    return _segment;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
