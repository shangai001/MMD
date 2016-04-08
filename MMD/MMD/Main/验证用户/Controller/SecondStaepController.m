//
//  SecondStaepController.m
//  MMD
//
//  Created by pencho on 16/3/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "SecondStaepController.h"
#import "ConstantHeight.h"
#import "ColorHeader.h"
#import "STPickerArea.h"
#import "STPickerSingle.h"
#import "VerifyModel.h"
#import "SecondVerifyItem.h"
#import <MJExtension.h>
#import <YYCGUtilities.h>
#import "VerifyModel.h"
#import "AppUserInfoHelper.h"
#import "VerifyViewController.h"


@interface SecondStaepController ()<UITextFieldDelegate,STPickerSingleDelegate,STPickerAreaDelegate>

//PickerData
@property (nonatomic, strong)NSArray *marriageArray;
@property (nonatomic, strong)NSArray *childrenArray;
@property (nonatomic, strong)NSArray *lifeArray;
@property (nonatomic, strong)NSArray *jobArray;
@property (nonatomic, strong)NSArray *cityArray;

//PickerView
@property (nonatomic, strong)STPickerArea *cityPickerView;
@property (nonatomic, strong)STPickerSingle *singlePickerView;
@property (nonatomic, strong)NSDictionary *picerDic;

@property (nonatomic, strong)SecondVerifyItem *item;

@end

@implementation SecondStaepController

- (STPickerSingle *)singlePickerView{
    if (!_singlePickerView) {
        _singlePickerView = [[STPickerSingle alloc] init];
        _singlePickerView.widthPickerComponent = 160;
        [_singlePickerView setContentMode:STPickerContentModeBottom];
        [_singlePickerView setDelegate:self];
    }
    return _singlePickerView;
}
- (STPickerArea *)cityPickerView{
    if (!_cityPickerView) {
        _cityPickerView = [[STPickerArea alloc] init];
        [_cityPickerView setContentMode:STPickerContentModeBottom];
        [_cityPickerView setDelegate:self];
    }
    return _cityPickerView;
}
- (SecondVerifyItem *)item{
    if (!_item) {
        _item = [SecondVerifyItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultValue];
    [self creatPicerinfoDictionary];
}
- (void)creatPicerinfoDictionary{
    self.picerDic = @{
                               @"Ma":@{
                                       @"type":@"0",
                                       @"title":@"请选择婚姻状况",
                                       @"tag":@(1000)
                                       },
                               @"Ch":@{
                                       @"type":@"1",
                                       @"title":@"请选择子女状况",
                                       @"tag":@(1001)
                                       },
                               @"LS":@{
                                       @"type":@"2",
                                       @"title":@"请选择生活半径",
                                       @"tag":@(1002)
                                       },
                               @"Job":@{
                                       @"type":@"3",
                                       @"title":@"请选择我是",
                                       @"tag":@(1003)
                                       }
                               };
    
}
- (void)setDefaultValue{
    self.nextButton.backgroundColor = REDCOLOR;
    self.nextButton.layer.cornerRadius = 10.0f;
    self.marriageArray = [NSArray array];
    self.lifeArray = [NSArray array];
    self.childrenArray = [NSArray array];
    self.jobArray = [NSArray array];
    self.cityArray = [NSArray array];
}
- (void)viewDidLayoutSubviews{
    self.contentWidth.constant = kScreenWidth;
    self.contentHeight.constant = kScreenHeight - kStageHeight;
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:_maritalStatusField]) {
        [self showSinglePcikerView:@"Ma"];
        return NO;
    }
    if ([textField isEqual:_childField]) {
        [self showSinglePcikerView:@"Ch"];
        return NO;
    }
    if ([textField isEqual:_lifeRadius]) {
        [self showSinglePcikerView:@"LS"];
        return NO;
    }
    if ([textField isEqual:_careerField]) {
        [self showSinglePcikerView:@"Job"];
        return NO;
    }
    if ([textField isEqual:_compangyCityField]) {
        [self showCityPicker:_compangyCityField];
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_compangyName]) {
        self.item.companyName = textField.text;
    }
    if ([textField isEqual:_compangyAddressField]) {
        self.item.companyAddress = textField.text;
    }
    if ([textField isEqual:_companyPhoneNum]) {
        self.item.companyPhone = textField.text;
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}
- (IBAction)nextAction:(id)sender {
    
    NSMutableDictionary *info = self.item.mj_keyValues;
    NSLog(@"输入的字典是%@",info);
    [VerifyModel postSecondInformation:info success:^(NSDictionary *resultDic) {
        if ([resultDic isKindOfClass:[NSDictionary class]] && [resultDic[@"code"] integerValue] == 0) {
            [AppUserInfoHelper updateUserInfo:resultDic];
            VerifyViewController *paVC = (VerifyViewController *)self.parentViewController;
            paVC.status = 2;
        }
    } failure:^(NSError *error) {
        
    }];
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
//记录下请求的数据
- (void)keepKeyArray:(NSInteger)type data:(NSArray *)dataArray{
    if (type == 0) {
        self.marriageArray = dataArray;
    }else if (type == 1){
        self.childrenArray = dataArray;
    }else if (type == 2){
        self.lifeArray = dataArray;
    }else if (type == 3){
        self.jobArray = dataArray;
    }
}
- (void)showCityPicker:(id)sender{
    [self.view endEditing:YES];
    [self.cityPickerView show];
}
#pragma mark STPickerDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
    
    NSString *fullAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.compangyCityField.text = fullAddress;
    //缺少地区id
    self.item.province = province;
    self.item.city = city;
    self.item.area = area;
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
    if ([key isEqualToString:@"Ma"]) {
        self.maritalStatusField.text = inputText;
        self.item.marriageKey = [self findoutKeyId:inputText inside:self.marriageArray];
    }else if ([key isEqualToString:@"Ch"]){
        self.childField.text = inputText;
        self.item.childrenKey = [self findoutKeyId:inputText inside:self.childrenArray];
    }else if ([key isEqualToString:@"LS"]){
        self.lifeRadius.text = inputText;
        self.item.lifeRadiusKey = [self findoutKeyId:inputText inside:self.lifeArray];
    }else if ([key isEqualToString:@"Job"]){
        self.careerField.text = inputText;
        self.item.positionKey = [self findoutKeyId:inputText inside:self.jobArray];
    }
}
//找出选中单项的对应Id
- (NSString *)findoutKeyId:(NSString *)text inside:(NSArray *)data{
    
    __block NSString *keyId = nil;
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *oneDic = (NSDictionary *)obj;
            NSString *valueString = oneDic[@"value"];
            if ([valueString isEqualToString:text]) {
                keyId = [NSString stringWithFormat:@"%@",oneDic[@"key"]];
            }
        }
    }];
    return keyId;
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
