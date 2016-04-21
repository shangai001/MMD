//
//  PostRepayController.m
//  MMD
//
//  Created by pencho on 16/4/21.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "PostRepayController.h"
#import "ColorHeader.h"
#import "RepayItem.h"
#import "UITextField+DatePicker.h"
#import "RepayIUploadModel.h"
#import <SVProgressHUD.h>


@interface PostRepayController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *cardIdNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UIButton *addPicture;

@property (nonatomic, strong)UIImagePickerController *picker;

@property (strong, nonatomic)RepayItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

@implementation PostRepayController

- (UIImagePickerController *)picker{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.sourceType = sourcheType;
        _picker.delegate = self;
        _picker.allowsEditing = NO;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            NSLog(@"支持相机");
        }
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            NSLog(@"支持图库");
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            NSLog(@"支持相片库");
        }
    }
    return _picker;
}

-(RepayItem *)item{
    if (!_item) {
        _item = [RepayItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureButton];
    [self configureTextField];
}
- (void)configureButton{
    
    self.sureButton.backgroundColor = REDCOLOR;
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.tintColor = [UIColor whiteColor];
}
- (void)configureTextField{
    
    self.timeTextField.datePickerInput = YES;
    self.timeTextField.maxDate = [NSDate date];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sureAction:(id)sender {
    
    if (self.selectedImageView.image) {
        [self uploadRepayInfo:self.selectedImageView.image];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择上传图片"];
    }
}
- (IBAction)addPictureAction:(id)sender {
    
    UIAlertController *actionViewController = [UIAlertController alertControllerWithTitle:@"汇款通知" message:@"请从以下方式选择上传您的汇款凭证" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //如果允许相册
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.picker animated:YES completion:^{
            
        }];
    }];

    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.picker animated:YES completion:^{
            
        }];
    }];
    [actionViewController addAction:cancelAction];
    if (self.albumOptional) {
       [actionViewController addAction:albumAction];
    }
    [actionViewController addAction:takePhotoAction];
    [self presentViewController:actionViewController animated:YES completion:nil];
}
#pragma mark UIImagePickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (originalImage) {
        self.selectedImageView.image = originalImage;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    self.selectedImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)uploadRepayInfo:(id)content{
    if ([content isKindOfClass:[UIImage class]]) {
        UIImage *upImage = (UIImage *)content;
        [SVProgressHUD show];
        [RepayIUploadModel uploadRepayInfo:upImage success:^(NSDictionary *resultDic) {
            [SVProgressHUD dismiss];
            if ([resultDic[@"code"] integerValue] == 0) {
                NSLog(@"上传汇款凭证成功");
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"上传失败,请检查网络"];
        }];
    }
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.cardIdNumLabel]) {
        self.item.cardNumber = textField.text;
    }
    if ([textField isEqual:self.numTextField]) {
        self.item.amount = textField.text;
     }

}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}// called when 'return' key pressed. return NO to ignore.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
