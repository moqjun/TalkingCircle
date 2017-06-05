//
//  ZYLPickerView.h
//  PickerView
//
//  Created by zhuyuelong on 16/7/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZYLPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

/**
 *  存放数据的数组
 */
@property (nonatomic,strong)NSMutableArray *firstArray;
@property (nonatomic,strong)NSMutableArray *secondArray;
@property (nonatomic,strong)NSMutableArray *thirdArray;

@property (nonatomic,assign) NSInteger numberOfComponents;

/**
 *  pickerview
 */
@property (strong, nonatomic) UIPickerView *pickerView;

/**
 *  年月 文本
 */
@property (strong, nonatomic) UILabel *lbProCityName;

/**
 *  年月
 */
@property (copy, nonatomic) NSString *yearMonth;



/**
 *  取消按钮
 */
@property (strong, nonatomic) UIButton *cancelBtn;

/**
 *  确定按钮
 */
@property (strong, nonatomic) UIButton *confirmBtn;

@property (nonatomic,assign) BOOL isShowed;

/**
 *  删除视图
 */
-(void)disMiss;

-(void)didSelectRow:(NSInteger) row inComponent:(NSInteger) component;

@property (nonatomic,copy) void(^SelectBlock)(NSString *yearMonth);


@end
