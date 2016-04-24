//
//  JobViewController.m
//  MMD
//
//  Created by pencho on 16/4/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "JobViewController.h"
#import "STPickerSingle.h"
#import "VerifyModel.h"
#import "JobItem.h"
#import "STPickerArea.h"
#import "AppUserInfoHelper.h"
#import "ColorHeader.h"


@interface JobViewController ()<UITextFieldDelegate,STPickerSingleDelegate,STPickerAreaDelegate>

@property (weak, nonatomic) IBOutlet UITextField *jobTextField;
@property (weak, nonatomic) IBOutlet UITextField *compangyName;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *compangyAdressTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyPhone;
@property (weak, nonatomic) IBOutlet UILabel *phoneTipLabel;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;


@property (nonatomic, strong)STPickerArea *cityPickerView;
@property (nonatomic, strong)STPickerSingle *singlePickerView;
@property (nonatomic, strong)NSArray *jobArray;

@property (nonatomic, strong)NSDictionary *picerDic;
@property (nonatomic, strong)JobItem *item;

@property (nonatomic, assign)BOOL isChanged;

@end

@implementation JobViewController

- (JobItem *)item{
    if (!_item) {
        _item = [JobItem new];
    }
    return _item;
}

- (STPickerSingle *)singlePickerView{
    if (!_singlePickerView) {
        _singlePickerView = [[STPickerSingle alloc] init];
        _singlePickerView.widthPickerComponent = 160;
        [_singlePickerView setContentMode:STPickerContentModeBottom];
        [_singlePickerView setDelegate:self];
    }
    return _singlePickerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initDefault];
    [self getOldJobInfo];
}
- (void)getOldJobInfo{
    
    NSDictionary *userJob = [AppUserInfoHelper userJob];
    NSString *jobName = userJob[@"jobName"];
    self.jobTextField.text = jobName;
    
    NSString *company = userJob[@"company"];
    self.compangyName.text = company;
    NSString *province = userJob[@"province"];
    NSString *city = userJob[@"city"];
    NSString *area = userJob[@"area"];
    NSString *fullAdress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.cityTextField.text = fullAdress;
    
    self.compangyAdressTextField.text = userJob[@"address"];
    self.companyPhone.text = userJob[@"phone"];
    
    self.phoneTipLabel.hidden = YES;
}
- (void)initDefault{
    self.jobArray = [NSArray array];
    self.picerDic = @{
//                      @"Ma":@{
//                              @"type":@"0",
//                              @"title":@"请选择婚姻状况",
//                              @"tag":@(1000)
//                              },
//                      @"Ch":@{
//                              @"type":@"1",
//                              @"title":@"请选择子女状况",
//                              @"tag":@(1001)
//                              },
//                      @"LS":@{
//                              @"type":@"2",
//                              @"title":@"请选择生活半径",
//                              @"tag":@(1002)
//                              },
                      @"Job":@{
                              @"type":@"3",
                              @"title":@"请选择我是",
                              @"tag":@(1003)
                              }
                      };
    
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.backgroundColor = REDCOLOR;
    [self.sureButton setTitle:@"填写/修改工作信息" forState:UIControlStateNormal];
    [self.sureButton setTitle:@"确定" forState:UIControlStateSelected];
    [self.sureButton setTintColor:[UIColor clearColor]];
}
- (void)setIsEditing:(BOOL)isEditing{
    _isEditing = isEditing;
    
    self.phoneTipLabel.hidden = !_isEditing;
    self.jobTextField.userInteractionEnabled=self.compangyName.userInteractionEnabled=self.cityTextField.userInteractionEnabled=self.compangyAdressTextField.userInteractionEnabled=self.companyPhone.userInteractionEnabled = !_isEditing;
}
//显示单项选择器(sender必须是Ma/Ch/LS/Job其一)
- (void)showSinglePcikerView:(id)sender{
    [self.view endEditing:YES];
    if ([sender isKindOfClass:[NSString class]]) {
        NSString *pickerKey = (NSString *)sender;
        NSDictionary *oneDic = self.picerDic[pickerKey];
        
        NSInteger pickerTag = [oneDic[@"tag"] integerValue];
        NSString *title = oneDic[@"title"];
        NSInteger type = [oneDic[@"type"] integerValue];
        
        [VerifyModel getPicerData:type success:^(NSDictionary *resultDic) {
            NSArray *data = resultDic[@"data"];
            //持有对应的数组数据
            [self keepKeyArray:type data:data];
            NSMutableArray *currentPickerArray = [self getSingleDataArray:data];
            [self.singlePickerView setArrayData:currentPickerArray];
            [self.singlePickerView ez_reloadAllComponents];
            [self.singlePickerView setTitle:title];
            self.singlePickerView.tag = pickerTag;
            [self.singlePickerView show];
        } failure:^(NSError *error) {
            
        }];
    }
}
#pragma mark ShowPicker
- (NSMutableArray *)getSingleDataArray:(NSArray *)data{
    if (data == nil)        return nil;
    NSMutableArray *singleArray = [NSMutableArray arrayWithCapacity:data.count];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            id object = dic[@"value"];
            if ([object isKindOfClass:[NSString class]]) {
                [singleArray addObject:object];
            }
        }
    }];
    return singleArray;
}
//记录下请求的数据
- (void)keepKeyArray:(NSInteger)type data:(NSArray *)dataArray{
    self.jobArray = dataArray;
}
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    
    NSInteger pickerTag = pickerSingle.tag;
    [self.picerDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *oneDic = (NSDictionary *)obj;
            NSInteger tag = [oneDic[@"tag"] integerValue];
            if (tag == pickerTag) {
                if ([key isKindOfClass:[NSString class]]) {
                    NSString *dicKey = (NSString *)key;
                    [self findOutWhichTextField:dicKey text:selectedTitle];
                }
            }
        }
    }];
}
//找出pickerView对应的textField,并且赋值
- (void)findOutWhichTextField:(NSString *)key text:(NSString *)inputText{
    if ([key isEqualToString:@"Job"]) {
        self.jobTextField.text = inputText;
        self.item.jobkey = key;
        self.isChanged = YES;
    }
}
#pragma mark ShowPickerView
- (void)showAreaPicker{
    [self.view endEditing:YES];
    if (!self.cityPickerView) {
        self.cityPickerView = [[STPickerArea alloc]init];
    }
    [self.cityPickerView setDelegate:self];
    [self.cityPickerView setContentMode:STPickerContentModeBottom];
    [self.cityPickerView show];
}
#pragma mark STPickerAreaDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
    NSString *cityAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.item.area = area;
    self.item.city = city;
    self.item.province = province;
    self.cityTextField.text = cityAddress;
    self.isChanged = YES;
}
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.isEditing) {
        if ([textField isEqual:self.jobTextField]) {
            [self showSinglePcikerView:@"Job"];
            return NO;
        }
        if ([textField isEqual:self.cityTextField]) {
            [self showAreaPicker];
            return NO;
        }
    }else{
        return NO;
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneAction:(id)sender {
    self.sureButton.selected = !self.sureButton.selected;
    self.isEditing = self.sureButton.selected;
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
