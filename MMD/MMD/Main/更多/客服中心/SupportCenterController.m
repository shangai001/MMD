//
//  SupportCenterController.m
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "SupportCenterController.h"
#import "ConstantTitle.h"
#import "ColorHeader.h"



@interface SupportCenterController ()

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *inputToolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTableToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottom;


@end

@implementation SupportCenterController

//- (UITableView *)chatTableView{
//    if (!_chatTableView) {
//        CGRect viewFrame = self.view.frame;
//        _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, viewFrame.size.width, viewFrame.size.height - 44) style:UITableViewStylePlain];
//        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _chatTableView.backgroundColor = BACKGROUNDCOLOR;
//    }
//    return _chatTableView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SUPPORTCENTER_TITLE;
}
- (void)addChatViewController{
 
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
