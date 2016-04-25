//
//  EditeAttachmentViewController.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "EditeAttachmentViewController.h"
#import "ColorHeader.h"
#import <UIButton+AFNetworking.h>

@interface EditeAttachmentViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *attImageButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation EditeAttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self setDefaultValue];
    [self configureButton];
}
- (void)setDefaultValue{
    
    self.nameTextField.text = self.attDic[@"title"];
    NSURL *imageURL = [NSURL URLWithString:self.attDic[@"url"]];
    [self.attImageButton setImageForState:UIControlStateNormal withURL:imageURL];
}
- (void)configureButton{
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.backgroundColor = REDCOLOR;
    
    
}
- (IBAction)clickAttachment:(id)sender {
    
    
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
