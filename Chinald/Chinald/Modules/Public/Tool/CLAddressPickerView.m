//
//  CLAddressPickerView.m
//  Chinald
//
//  Created by WPFBob on 2018/4/18.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLAddressPickerView.h"
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
@interface CLAddressPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSDictionary *_addressDic;
    NSMutableArray *_provinceArray;//省的数组
    NSMutableArray *_areaArray;//地区选择
    NSMutableArray *_cityArray;//市的数组
}
@property(nonatomic, strong)UIView *maskLayerView;  //!<
@property(nonatomic, strong)UIView *pickerBackgroundView;
@property(nonatomic, strong)UIPickerView *addressPicker;//地址选择器
  //!<
@end
@implementation CLAddressPickerView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _maskLayerView = [[UIView alloc]init];
        _maskLayerView.backgroundColor = [UIColor blackColor];
        _maskLayerView.alpha = 0;
        [self addSubview:_maskLayerView];
        [_maskLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.bottom.mas_offset(0);

        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissPickerView)];
        [_maskLayerView addGestureRecognizer:tapGesture];
        
        _pickerBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenFullHeight, ScreenFullWidth, 180)];
        _pickerBackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerBackgroundView];

        NSBundle *bundle = [NSBundle mainBundle];
        NSString *jsonPath = [bundle pathForResource:@"address" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:jsonPath];
        _addressDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _provinceArray = _addressDic[@"province"];


        [self addressPickerView];
    }
    return self;
}
-(void)addressPickerView{
    _addressPicker = [[UIPickerView alloc] initWithFrame: CGRectMake( 0, 30,ScreenFullWidth, 150)];
    _addressPicker.dataSource = self;
    _addressPicker.delegate = self;
    _addressPicker.showsSelectionIndicator = YES;
    [_addressPicker selectRow: 0 inComponent: 0 animated: YES];
    [_pickerBackgroundView addSubview:_addressPicker];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(-0.5, 0, ScreenFullWidth +1, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    
    
    [_pickerBackgroundView addSubview:topView];
    
    
    UIButton *escButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    escButton.titleLabel.font = [UIFont zntFont14];
    [escButton setTitleColor:[UIColor blackColor] forState:0];
    [escButton setTitle:@"取消" forState:0];
    [escButton addTarget:self action:@selector(escClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:escButton];
    
    UIButton *changeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 60, 7, 50, 30)];
    [changeButton setTitleColor:[UIColor blackColor] forState:0];
    
    changeButton.titleLabel.font =  [UIFont zntFont14];
    changeButton.layer.borderColor = [UIColor grayColor].CGColor;
    changeButton.layer.borderWidth = 1;
    changeButton.layer.cornerRadius = 5;
    [changeButton setTitle:@"完成" forState:0];
    [changeButton addTarget:self action:@selector(changeAddressClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:changeButton];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskLayerView.alpha = 0.2;
        _pickerBackgroundView.frame = CGRectMake(0, ScreenFullHeight - 180, ScreenFullWidth, 180);
    }];
}

#pragma mark- Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return _provinceArray.count;
    }
    else if (component == CITY_COMPONENT) {
        NSInteger firstIndex = [pickerView selectedRowInComponent:0];
        NSArray *city = [[_addressDic objectForKey:@"city"] objectForKey:_provinceArray[firstIndex][@"code"]];
        if (city!=nil) {
            return [city count];
        }else{
            return 0;
        }
    }else {
        NSInteger firstIndex = [pickerView selectedRowInComponent:0];
        NSArray *city = [[_addressDic objectForKey:@"city"] objectForKey:_provinceArray[firstIndex][@"code"]];
        if ([city count]==0) {
            return 0;
        }else{
            NSInteger secIndex = [pickerView selectedRowInComponent:1];
            NSArray *area = [[_addressDic objectForKey:@"area"] objectForKey:city[secIndex][@"code"]];

            if (area!=nil) {
                return [area count];
            }else{
                return 0;
            }
        }
        
    }
}
#pragma mark- Picker Delegate Methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    if (component == CITY_COMPONENT) {
        [pickerView reloadComponent:2];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *myAdressPaickView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myAdressPaickView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)] ;
        myAdressPaickView.textAlignment = NSTextAlignmentCenter;
        
        if (row < _provinceArray.count) {
            myAdressPaickView.text = [[_provinceArray objectAtIndex:row] objectForKey:@"name"];
        }
        myAdressPaickView.font = [UIFont systemFontOfSize:14];
        myAdressPaickView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myAdressPaickView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)] ;
        myAdressPaickView.textAlignment = NSTextAlignmentCenter;
        myAdressPaickView.font = [UIFont systemFontOfSize:14];
        myAdressPaickView.backgroundColor = [UIColor clearColor];
        
        NSInteger firstIndex = [pickerView selectedRowInComponent:0];

        if (firstIndex < _provinceArray.count) {
            
            NSArray *city = [[_addressDic objectForKey:@"city"] objectForKey:_provinceArray[firstIndex][@"code"]];
            if (city != nil) {
                //如果有二级则显示二级内容
                
                if (row < city.count) {
                    myAdressPaickView.text =[[city objectAtIndex:row] objectForKey:@"name"];
                }
            }else{
                //如果没有二级则显示一级内容
                myAdressPaickView.text = [[_provinceArray objectAtIndex:[pickerView selectedRowInComponent:0]] objectForKey:@"name"];
            }
        }
    }
    else {
        
        myAdressPaickView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)] ;
        myAdressPaickView.textAlignment = NSTextAlignmentCenter;
        myAdressPaickView.font = [UIFont systemFontOfSize:14];
        myAdressPaickView.backgroundColor = [UIColor clearColor];
        
        NSInteger firstIndex = [pickerView selectedRowInComponent:0];
        
        NSArray *city = [[_addressDic objectForKey:@"city"] objectForKey:_provinceArray[firstIndex][@"code"]];
        if ([city count]==0) {
            //只有一级 的时候显示 一级的名字
            
            if (firstIndex < _provinceArray.count ) {
                
                myAdressPaickView.text = [[_provinceArray objectAtIndex:firstIndex] objectForKey:@"name"];
            }
            
        }else{
            if (firstIndex < _provinceArray.count) {
                NSInteger secIndex = [pickerView selectedRowInComponent:1];
                NSArray *area = [[_addressDic objectForKey:@"area"] objectForKey:city[secIndex][@"code"]];

                if (area!=nil) {
                    //如果有三级则显示三级内容
                    if (row < area.count) {
                        myAdressPaickView.text = [[area objectAtIndex:row] objectForKey:@"name"];
                    }
                }else{
                    //如果只有两级 则显示第二级内容
                    if (secIndex < city.count) {
                        myAdressPaickView.text = [[city objectAtIndex:secIndex] objectForKey:@"name"];
                    }
                }
            }
        }
    }
    return myAdressPaickView;
}

-(void)changeAddressClick{
    
    NSInteger provinceIndex = [_addressPicker selectedRowInComponent:0];
    NSInteger cityIndex = [_addressPicker selectedRowInComponent:1];
    NSInteger areaIndex = [_addressPicker selectedRowInComponent:2];
    NSDictionary *provinceDic = _provinceArray[provinceIndex];
    NSArray *cityArray = [[_addressDic objectForKey:@"city"] objectForKey:_provinceArray[provinceIndex][@"code"]];
    NSDictionary *cityDic = cityArray[cityIndex];
    NSArray *areaArray = [[_addressDic objectForKey:@"area"] objectForKey:cityArray[cityIndex][@"code"]];
    NSDictionary *areaDic = areaArray[areaIndex];
    self.province = provinceDic[@"name"];
    self.city = cityDic[@"name"];
    self.area = areaDic[@"name"];
    self.provinceCode = provinceDic[@"code"];
    self.cityCode = cityDic[@"code"];
    self.areaCode = areaDic[@"code"];
    __block CLAddressPickerView *blockSelf = self;
    if (blockSelf.selectAddressClickBlock) {
        blockSelf.selectAddressClickBlock();
    }
    [self escClick];
}

-(void)dismissPickerView{
    [self escClick];
}
-(void)escClick{
    [UIView animateWithDuration:0.25 animations:^{
        _pickerBackgroundView.frame = CGRectMake(0, ScreenFullHeight, ScreenFullWidth, 180);
        _maskLayerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
