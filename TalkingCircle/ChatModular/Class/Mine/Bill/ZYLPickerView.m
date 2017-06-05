//
//  ZYLPickerView.m
//  PickerView
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import "ZYLPickerView.h"



@implementation ZYLPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.numberOfComponents = 2;
        
        self.backgroundColor = [UIColor grayColor];
        
        self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
        
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cancelBtn];
        
        self.confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 5, 40, 30)];
        
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.confirmBtn];
        
        self.lbProCityName = [[UILabel alloc] initWithFrame:CGRectMake(self.cancelBtn.frame.origin.x + self.cancelBtn.frame.size.width, 5, self.confirmBtn.frame.origin.x - self.cancelBtn.frame.size.width - self.cancelBtn.frame.origin.x, 30)];
        
        self.lbProCityName.text = @"请选择地点";
        
        self.lbProCityName.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.lbProCityName];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.lbProCityName.frame.origin.y + self.lbProCityName.frame.size.height, self.frame.size.width, self.frame.size.height - self.lbProCityName.frame.size.height)];
        
        self.pickerView.backgroundColor = [UIColor whiteColor];
        
        self.pickerView.delegate = self;
        
        self.pickerView.dataSource = self;
        
        [self addSubview:self.pickerView];
        
//        [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
        
        self.isShowed = YES;
    }
    
    return self;
    
}

#pragma mark - 取消按钮点击事件
-(void)cancelBtnClick{
    
    self.SelectBlock(nil);

    [self disMiss];
    
}

#pragma mark - 确定按钮点击事件
-(void)confirmBtnClick{
    
    self.SelectBlock(self.yearMonth);
    
    [self disMiss];

}

#pragma mark - 删除视图
-(void)disMiss{

    self.isShowed = NO;
    [self removeFromSuperview];

}

-(void) didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     [self pickerView:self.pickerView didSelectRow:row inComponent:component];
}

#pragma mark -懒加载
-(NSMutableArray *)firstArray{
    if (!_firstArray)
    {
         _firstArray = [NSMutableArray array];
//        for (NSInteger i=2000; i<=3000; i++)
//        {
//            NSString *str =[NSString stringWithFormat:@"%ld",i];
//            [_yearArray addObject:str];
//        }
    }
    return _firstArray;
}

-(NSMutableArray *)secondArray
{
    if (_secondArray == nil)
    {
        _secondArray = [NSMutableArray array];
//        _monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",
//                        @"8",@"9",@"10",@"11",@"12"];
    }
    return _secondArray;
}

-(NSMutableArray *)thirdArray
{
    if (_thirdArray == nil)
    {
        _thirdArray = [NSMutableArray array];
    }
    return _thirdArray;
}


#pragma mark - 实现 pickerview 协议
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.numberOfComponents;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return self.firstArray.count;
        
    }else if(component == 1){
        
       
        return self.secondArray.count;
        
    }
    else
    {
        return self.thirdArray.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0)
    {
        return self.firstArray[row];
        
    }else if (component == 1)
    {
        return self.secondArray[row];
    }
    else
    {
        return self.thirdArray[row];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        [pickerView reloadComponent:1];
        
    }

    NSInteger selePro = [pickerView selectedRowInComponent:0];
    NSInteger seleCity = [pickerView selectedRowInComponent:1];
    
    NSInteger seleCounty = 0;
    NSString * day = nil;
    if (self.numberOfComponents == 3)
    {
        seleCounty=[pickerView selectedRowInComponent:2];
        if (self.thirdArray.count)
        {
            day = self.thirdArray[seleCounty];
        }
    }
   
    
    NSString * year = self.firstArray[selePro];

    NSString * month = self.secondArray[seleCity];
    
    if (day)
    {
        self.yearMonth = [NSString stringWithFormat:@"%@%@%@",year,month,day];
    }
    else
    {
        self.yearMonth = [NSString stringWithFormat:@"%@年%@月",year,month];
    }
    
    
    
    self.lbProCityName.text = self.yearMonth;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
