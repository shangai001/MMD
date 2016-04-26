//
//  EditeAttachmentViewController.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "EditeAttachmentViewController.h"
#import "ColorHeader.h"
#import <UIImageView+YYWebImage.h>
#import <NSData+YYAdd.h>
#import "QueryAttachmentModel.h"
#import <SVProgressHUD.h>



@interface EditeAttachmentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *attImageView;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
/**
 *  是否审核通过
 */
@property (nonatomic, assign)BOOL isPassed;
@property (nonatomic, strong)UIImagePickerController *picker;

@property (nonatomic, strong)UIImage *attImage;
@property (nonatomic, copy)NSString *attTitle;
//上传类型(拍照，手机相册)
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *base64String;

@end

@implementation EditeAttachmentViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"编辑/添加附件";
    [self setDefaultValue];
    [self configureButton];
}
- (void)setDefaultValue{
    
    if (self.attDic) {
        self.nameTextField.text = self.attDic[@"title"];
        
        [self.indicator startAnimating];
        NSURL *imageURL = [NSURL URLWithString:self.attDic[@"url"]];
        [self.attImageView setImageWithURL:imageURL placeholder:nil options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if (image) {
                [self.indicator stopAnimating];
            }
        }];
        
        NSString *state = self.attDic[@"state"];
        if ([state isEqualToString:@"2"]) {
            self.isPassed = YES;
        }
    }
}
- (void)configureButton{
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.backgroundColor = REDCOLOR;
    self.sureButton.tintColor = [UIColor whiteColor];
}
- (IBAction)clickAttachment:(id)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择图片位置" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancleAction];
    /**
     *      UIImagePickerControllerSourceTypePhotoLibrary,
     UIImagePickerControllerSourceTypeCamera,
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     */
    if (!self.isPassed) {
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.picker animated:YES completion:nil];
        }];
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:self.picker animated:YES completion:nil];
        }];
        [alertVC addAction:takePhotoAction];
        [alertVC addAction:albumAction];
    }else{
        UIAlertAction *previewAction = [UIAlertAction actionWithTitle:@"预览大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:previewAction];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark UIImagePickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    self.attImage = image;
    self.type = @"拍照";
    self.attImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (originalImage) {
        self.attImage = originalImage;
        if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
            self.type = @"相册";
        }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            self.type = @"拍照";
        }
        self.attImageView.image = originalImage;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.nameTextField]) {
        self.attTitle = textField.text;
    }
}
#pragma mark SeeBigPhoto

- (IBAction)sureAction:(id)sender {
    
    if (self.attImage && self.attTitle) {
        NSData *imageData = UIImageJPEGRepresentation(self.attImage, 0.75);
        NSString *base64String = [imageData base64EncodedString];
        
        NSMutableDictionary *infoDic =[NSMutableDictionary dictionary];
        [infoDic setObject:base64String forKey:@"base64Str"];
        [infoDic setObject:self.type forKey:@"type"];
        [infoDic setObject:self.attTitle forKey:@"title"];
        if (self.attDic) {
            NSString *attId = self.attDic[@"id"];
            [infoDic setObject:attId forKey:@"id"];
        }
        
        [SVProgressHUD show];
        [QueryAttachmentModel uploadAttachment:infoDic success:^(NSDictionary *resultDic) {
            [SVProgressHUD dismiss];
            if ([resultDic[@"code"] integerValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请重新编辑附件"];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
